# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_transport(
  name: 'cobblerapi',
  desc: <<-EOS,
      This transport provides Puppet with the capability to connect to cobblerapi targets.
    EOS
  features: [],
  connection_info: {
    uri: {
      type: 'String',
      desc: 'The uri to connect to for this target.',
    },
    user: {
      type: 'String',
      desc: 'The name of the user to authenticate as.',
    },
    password: {
      type:      'String',
      desc:      'The password for the user.',
      sensitive: true,
    },
  },
)
