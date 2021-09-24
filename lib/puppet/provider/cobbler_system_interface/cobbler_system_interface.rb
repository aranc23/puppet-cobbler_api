# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'

# Implementation for the cobbler_system_interface type using the Resource API.
class Puppet::Provider::CobblerSystemInterface::CobblerSystemInterface < Puppet::ResourceApi::SimpleProvider
  def initialize
    @system_interfaces = []
    # hash of interfaces indexed by the system to which they belong
    unless @client
      @client = XMLRPC::Client.new2(ENV['COBBLER_URI'])
    end
    unless @token and _version = @client.call('version',@token)
      @token = @client.call('login', ENV['COBBLER_USER'], ENV['COBBLER_PASSWORD'])
    end
    super()
  end
  def get(context)
    context.debug('Returning system interface data')
    unless @system_interfaces.length > 0 
      gs = @client.call('get_systems')
      context.debug("#{gs.inspect}")
      #simple_xlate = %w( name hostname owners profile image status kernel_options kernel_options_post autoinstall_meta boot_loader proxy netboot_enable kickstart comment enable_gpxe server next_server filename gateway name_servers name_servers_search ipv6_default_device ipv6_autoconfiguration )
      
      gs.each do |s|
        if s.has_key?('interfaces')
          s['interfaces'].each do |int_name,int_hash|
            newhash = { :ensure => 'present',
                        :interface => int_name,
                        :system => s['name'],
                        :title => "#{s['name']}::#{int_name}",
                      }
            int_hash.each do |k,v|
              if k == 'connected_mode'
                # this doesn't seem to appear on the web interface,
                # and I'm not sure what it does
                next
              end
              if ['mtu','ipv6_mtu'].include?(k)
                newhash[k.to_sym] = v.to_i
              elsif k == 'mac_address' and v[0..7] == '00:16:3e'
                # this is a "random" mac address, so return random not
                # the mac so it matches, or doesn't, the specified
                # mac_address for the system
                newhash[k.to_sym] = 'random'
              else
                newhash[k.to_sym] = v
              end
            end
            @system_interfaces << newhash
          end
        end
      end
      context.debug(@system_interfaces)
    end
    @system_interfaces
  end

  def create(context, name, should)
    context.notice("Creating (or updating) '#{name}' with #{should.inspect}")
    system = should[:system]
    # do not pass these as values, as they are not cobbler parameters
    [
      :title,
      :system,
      :ensure
    ].each do |sym|
      if should.has_key?(sym)
        should.delete(sym)
      end
    end

    values = {}
    should.map do |k,v|
      if v == ''
        next
      end
      values[k.to_s] = v
    end
    context.notice("#{values.inspect}")
    @client.call('xapi_object_edit',
                 'system',
                 system,
                 'edit',
                 values,
                 @token)
  end

  def update(context, name, should)
    context.notice("Updating '#{name}' with #{should.inspect}")
    system = should[:system]
    [
      :title,
      :system,
      :ensure
    ].each do |sym|
      if should.has_key?(sym)
        should.delete(sym)
      end
    end
    values = {}
    should.map do |k,v|
      if v == ''
        next
      end
      values[k.to_s] = v
    end
    context.notice("#{values.inspect}")
    @client.call('xapi_object_edit',
                 'system',
                 system,
                 'edit',
                 values,
                 @token)
  end

  def delete(context, name)
    context.notice("Deleting '#{name[:system]}::#{name[:interface]}'")
    # this works, but I don't know what if anything the parameter to
    # delete_interface should be:
    values = { 'interface' => name[:interface], 'delete_interface' => name[:interface] }
    context.notice("#{values.inspect}")
    @client.call('xapi_object_edit',
                 'system',
                 name[:system],
                 'edit',
                 values,
                 @token)
  end
end
