# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'cobbler_system',
  docs: <<-EOS,
@summary a cobbler_system type
@example
cobbler_system { 'foo':
  ensure => 'present',
}

This type provides Puppet with the capabilities to manage cobbler system resources via the api.

EOS
  #features: [ 'remote_resource' ],
  attributes: {
    ensure: {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },
    cobbler_uri: {
      type: 'String',
      desc: 'URI of cobbler server.',
      behaviour: :parameter,
      default: 'http://127.0.0.1/cobbler_api',
    },
    cobbler_user: {
      type: 'String',
      desc: 'Cobbler user.',
      behaviour: :parameter,
      default: 'testing',
    },
    cobbler_password: {
      type: 'String',
      desc: 'Cobbler password.',
      behaviour: :parameter,
      default: 'testing',
    },

    name: {
      type: 'String',
      desc: 'The name of system.',
      behaviour: :namevar,
    },
    hostname: {
      type: 'String',
      desc: 'The hostname of the system.',
    },
    profile: {
      type: 'String',
      desc: 'The profile associated with this system.',
    },
    image: {
      type: 'String',
      desc: 'The image associated with this system.',
    },

  },
)
