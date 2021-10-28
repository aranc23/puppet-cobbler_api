# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'
require 'xmlrpc/client'

# Implementation for the cobbler_profile type using the Resource API.
class Puppet::Provider::CobblerProfile::CobblerProfile < Puppet::ResourceApi::SimpleProvider
  def initialize
    @profiles = []
    unless @client
      @client = XMLRPC::Client.new2(ENV['COBBLER_URI'])
    end
    unless @token and _version = @client.call('version',@token)
      @token = @client.call('login', ENV['COBBLER_USERNAME'], ENV['COBBLER_PASSWORD'])
    end
    super()
  end
  def get(context)
    context.debug('Returning system data')
    unless @profiles.length > 0 
      gs = @client.call('get_profiles')
      context.debug("#{gs.inspect}")
      simple_xlate = %w( name owners distro parent enable_menu autoinstall kernel_options kernel_options_post autoinstall_meta proxy repos comment enable_gpxe dhcp_tag server next_server filename name_servers name_servers_search )
      
      gs.each do |s|
        st = { :ensure => 'present' }
        simple_xlate.each do |x|
          if s.has_key?(x)
            st[x.to_sym] = s[x]
          end
        end
        @profiles << st
      end
      context.debug(@profiles)
    end
    @profiles
  end
  def create(context, name, should)
    context.notice("Creating '#{name}' with #{should.inspect}")
    values = {}
    should.map do |k,v|
      if v == '' or k == :ensure
        next
      end
      values[k.to_s] = v
    end
    context.notice("#{values.inspect}")
    @client.call('xapi_object_edit',
                 'profile',
                 name,
                 'add',
                 values,
                 @token)
  end
  def update(context, name, should)
    context.notice("Updating '#{name}' with #{should.inspect}")
    values = {}
    should.map do |k,v|
      if k == :ensure or k == :name
        next
      end
      values[k.to_s] = v
    end
    context.notice("#{values.inspect}")
    @client.call('xapi_object_edit',
                 'profile',
                 name,
                 'edit',
                 values,
                 @token)
    context.debug("finished updating #{name}")
  end

  def delete(context, name)
    context.notice("Deleting '#{name}'")
    @client.call('xapi_object_edit',
                 'profile',
                 name,
                 'remove',
                 {},
                 @token)
  end
end
