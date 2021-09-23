# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'
require 'xmlrpc/client'

# Implementation for the cobbler_system type using the Resource API.
class Puppet::Provider::CobblerSystem::CobblerSystem < Puppet::ResourceApi::SimpleProvider
  def initialize
    @systems = []
    #context = super()
    #context.debug("initializing connection to the cobbler api")
    unless @client
      @client = XMLRPC::Client.new2(ENV['COBBLER_URI'])
    end
    unless @token and _version = @client.call('version',@token)
      @token = @client.call('login', ENV['COBBLER_USER'], ENV['COBBLER_PASSWORD'])
    end
    super()
  end
  def get(context)
    context.debug('Returning system data')
    unless @systems.length > 0 
      gs = @client.call('get_systems')
      context.debug("#{gs.inspect}")
      simple_xlate = %w( name hostname owners profile image status kernel_options kernel_options_post autoinstall_meta boot_loader proxy netboot_enable kickstart comment enable_gpxe server next_server filename gateway name_servers name_servers_search ipv6_default_device ipv6_autoconfiguration )
      
      gs.each do |s|
        st = { :ensure => 'present' }
        simple_xlate.each do |x|
          if s.has_key?(x)
            st[x.to_sym] = s[x]
          end
        end
        @systems << st
      end
      context.debug(@systems)
    end
    @systems
  end

  def create(context, name, should)
    context.notice("Creating '#{name}' with #{should.inspect}")
    #initialize(context)
    values = {}
    should.map do |k,v|
      if v == '' or k == :ensure
        next
      end
      values[k.to_s] = v
    end
    context.notice("#{values.inspect}")
    @client.call('xapi_object_edit',
                 'system',
                 name,
                 'add',
                 values,
                 @token)
    #@client.call('sync',@token)
  end

  def update(context, name, should)
    context.notice("Updating '#{name}' with #{should.inspect}")
    #initialize(context)
    values = {}
    should.map do |k,v|
      if k == :ensure or k == :name
        next
      end
      if k == 'interfaces'
        values[k.to_s] = to_json(v)
      end
      values[k.to_s] = v
    end
    context.notice("#{values.inspect}")
    @client.call('xapi_object_edit',
                 'system',
                 name,
                 'edit',
                 values,
                 @token)
    # context.debug("trying to update the interfaces parameter of #{name}")
    # system_handle = @client.call('get_system_handle',name, @token)
    # context.debug("got handle of #{name} and going to update #{should[:interfaces].inspect}")
    # @client.call('modify_system',system_handle,'interfaces',should[:interfaces],@token)
    # context.debug("updated interfaces, about to save #{name}")
    # @client.call('save_system',system_handle,@token)
    context.debug("finished updating #{name}")
    #@client.call('sync',@token)
  end

  def delete(context, name)
    context.notice("Deleting '#{name}'")
    #initialize(context)
    @client.call('xapi_object_edit',
                 'system',
                 name,
                 'remove',
                 {},
                 @token)
    #@client.call('sync',@token)
  end
end
