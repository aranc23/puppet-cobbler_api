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

  attributes: {
    ensure: {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },
    name: {
      type: 'String',
      desc: 'The name of system.',
      behaviour: :namevar,
    },
    hostname: {
      type: 'String',
      desc: 'The hostname of the system.',
      default: '',
    },
    profile: {
      type: 'String',
      desc: 'The profile associated with this system.',
      default: '',
    },
    image: {
      type: 'String',
      desc: 'The image associated with this system.',
      default: '',
    },
    boot_loader: {
      type: 'String',
      desc: 'The boot loader for the system.',
      default: '<<inherit>>',
    },
    comment: {
      type: 'Variant[String,Undef]',
      desc: 'Cobbler system comment.',
      default: undef,
    },
  },
)
