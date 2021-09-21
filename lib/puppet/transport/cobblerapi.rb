# frozen_string_literal: true
require 'puppet/resource_api/simple_provider'
require 'xmlrpc/client'


module Puppet::Transport
  # The main connection class to a Cobblerapi endpoint
  class Cobblerapi
    # Initialise this transport with a set of credentials
    def initialize(context, connection_info)
      # because `password` is marked sensitive, we can log it here and it will be masked
      context.debug("Connecting to #{connection_info[:user]}:#{connection_info[:password]}@#{connection_info[:uri]}")
      # store the credentials for later use
      # alternatively, connect right here
      @connection_info = connection_info

      @islive = true

      @connection_info = connection_info
      if connection_info[:url] == 'unit-testing' then
        @islive = false
      else
        @client = XMLRPC::Client.new2(connection_info[:uri])
        @session = @client.call('login', connection_info[:username], connection_info[:password].unwrap)
      end
      @facts = facts(context)
    end

    # Verifies that the stored credentials are valid, and that we can talk to the target
    def verify(context)
      context.debug("Checking connection to #{@connection_info[:uri]}")
      # in a real world implementation, the password would be checked by connecting
      # to the target device or checking that an existing connection is still alive
      raise 'authentication error' if @connection_info[:password].unwrap == 'invalid'
      if connection_info[:url] != 'unit-testing' then
        @client = XMLRPC::Client.new2(connection_info[:uri])
        @session = @client.call('login', connection_info[:username], connection_info[:password].unwrap)
      end
    end

    # Retrieve facts from the target and return in a hash
    def facts(context)
      context.debug('Retrieving facts')
      {
        cobbler: {
          extended_version: {"gitdate"=>"Thu Mar 4 20:07:10 2021 +0100", "gitstamp"=>"c7fc767c", "builddate"=>"Thu Dec 19 00:00:00 2019", "version"=>"3.2.1", "version_tuple"=>[3, 2, 1]},
          version: '3.201',
          settings: { stuff: 'nonsense' }
        }
      }
      {
        cobbler: {
          extended_version: @client.call('extended_version',@session),
          version: @client.call('version',@session),
          settings: @client.call('get_settings',@session),
        }
      }
    end

    # Close the connection and release all resources
    def close(context)
      context.debug('Closing connection')
      @connection_info = nil
      @session = nil
    end
  end
end
