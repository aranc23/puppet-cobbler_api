# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'
require 'xmlrpc/client'

# Implementation for the cobbler_system type using the Resource API.
class Puppet::Provider::CobblerSystem::CobblerSystem < Puppet::ResourceApi::SimpleProvider
  def initialize
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
    context.debug('Returning pre-canned example data')
    # [
    #   {
    #     name: 'foo',
    #     ensure: 'present',
    #   },
    #   {
    #     name: 'bar',
    #     ensure: 'present',
    #   },
    # ]
    # self.initialize(context)
    #initialize(context)
    systems = []
    gs = @client.call('get_systems')
    context.debug("#{gs.inspect}")
    simple_xlate = %w( name hostname profile image boot_loader comment )
      
    gs.each do |s|
      st = { :ensure => 'present' }
      simple_xlate.each do |x|
        if s.has_key?(x)
          st[x.to_sym] = s[x]
        end
      end
      systems << st
    end
    context.debug(systems)
    systems
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
      values[k.to_s] = v
    end
    context.notice("#{values.inspect}")
    @client.call('xapi_object_edit',
                 'system',
                 name,
                 'edit',
                 values,
                 @token)
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
