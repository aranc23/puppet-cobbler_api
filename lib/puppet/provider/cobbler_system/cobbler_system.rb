# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'

# Implementation for the cobbler_system type using the Resource API.
class Puppet::Provider::CobblerSystem::CobblerSystem < Puppet::ResourceApi::SimpleProvider
  def initialize(context)
    context.debug("initializing connection to the cobbler api")
    unless @client
      @client = XMLRPC::Client.new2(cobbler_uri)
    end
    unless @token and _version = @client.call('version',@token)
      @token = @client.call('login', cobbler_user, cobbler_password)
    end
  end
  def get(context)
    context.debug('Returning pre-canned example data')
    [
      {
        name: 'foo',
        ensure: 'present',
      },
      {
        name: 'bar',
        ensure: 'present',
      },
    ]
    initialize(context)
    i = @client.call('list_systems',@token)
    context.debug(i.inspect)
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
