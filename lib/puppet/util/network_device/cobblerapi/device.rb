# frozen_string_literal: true

require 'puppet/resource_api/transport/wrapper'

# Initialize the NetworkDevice class if necessary
class Puppet::Util::NetworkDevice; end

# The Cobblerapi module only contains the Device class to bridge from puppet's internals to the Transport.
# All the heavy lifting is done bye the Puppet::ResourceApi::Transport::Wrapper
module Puppet::Util::NetworkDevice::Cobblerapi
  # Bridging from puppet to the cobblerapi transport
  class Device < Puppet::ResourceApi::Transport::Wrapper
    def initialize(url_or_config, _options = {})
      super('cobblerapi', url_or_config)
    end
  end
end
