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
      simple_xlate = %w( name owners arch breed keep_updated mirror rpm_list comment proxy apt_components apt_dists createrepo_flags environment mirror_locally priority yumopts rsyncopts )
      
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
    values = {}
    should.map do |k,v|
      if v == '' or k == :ensure
        next
      end
      values[k.to_s] = v
    end
    context.notice("#{values.inspect}")
    @client.call('xapi_object_edit',
                 'repo',
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
                 'repo',
                 name,
                 'edit',
                 values,
                 @token)
    context.debug("finished updating #{name}")
  end

  def delete(context, name)
    context.notice("Deleting '#{name}'")
    @client.call('remove_repo',name,@token,false)
  end
end
