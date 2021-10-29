# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'

# Implementation for the cobbler_repo type using the Resource API.
class Puppet::Provider::CobblerRepo::CobblerRepo < Puppet::ResourceApi::SimpleProvider
  def initialize
    @repos = []
    @version = ''
    unless @client
      @client = XMLRPC::Client.new2(ENV['COBBLER_URI'])
    end
    unless @token and _version = @client.call('version',@token)
      @token = @client.call('login', ENV['COBBLER_USERNAME'], ENV['COBBLER_PASSWORD'])
    end
    @version = @client.call('version',@token)
    super()
  end
  def get(context)
    context.debug("Returning repo data from cobbler #{@version}")
    unless @repos.length > 0 
      gs = @client.call('get_repos')
      #context.debug("#{gs.inspect}")
      simple_xlate = %w( name hostname owners profile image status kernel_options kernel_options_post autoinstall_meta boot_loader proxy netboot_enable autoinstall comment enable_gpxe server next_server filename gateway name_servers name_servers_search ipv6_default_device ipv6_autoconfiguration )
      
      gs.each do |s|
        st = { :ensure => 'present' }
        simple_xlate.each do |x|
          if s.has_key?(x)
            st[x.to_sym] = s[x]
          end
        end
        @repos << st
      end
    end
    @repos
  end

  def create(context, name, should)
    context.notice("Creating '#{name}' with #{should.inspect}")
  end

  def update(context, name, should)
    context.notice("Updating '#{name}' with #{should.inspect}")
  end

  def delete(context, name)
    context.notice("Deleting '#{name}'")
  end
end
