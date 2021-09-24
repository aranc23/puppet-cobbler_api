# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'cobbler_system_interface',
  docs: <<-EOS,
@summary a cobbler_system_interface type
@example
cobbler_system_interface { 'foo::eth0':
  ensure => 'present',
}

This type provides Puppet with the capabilities to manage ...

If your type uses autorequires, please document as shown below, else delete
these lines.
**Autorequires**:
* `Package[foo]`
EOS
  features: [],
  title_patterns: [
    {
      pattern: %r{^(?<system>.+?)::(?<interface>.+)$},
      desc: 'Where the package and the manager are provided with a hyphen seperator',
    },
  ],
  attributes: {
    ensure: {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },
    system: {
      type:      'String',
      desc:      'The name of the system to which the interface belongs.',
      behaviour: :namevar,
    },
    interface: {
      type:      'String',
      desc:      'The name of the interface on the system.',
      behaviour: :namevar,
    },
  },
)
