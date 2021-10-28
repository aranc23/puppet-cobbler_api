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

    #   "e": {
    #   "bonding_opts": "",
    #   "bridge_opts": "",
    #   "cnames": [],
    #   "connected_mode": false,
    #   "dhcp_tag": "",
    #   "dns_name": "",
    #   "if_gateway": "",
    #   "interface_master": "",
    #   "interface_type": "",
    #   "ip_address": "",
    #   "ipv6_address": "",
    #   "ipv6_default_gateway": "",
    #   "ipv6_mtu": "",
    #   "ipv6_prefix": "",
    #   "ipv6_secondaries": [],
    #   "ipv6_static_routes": [],
    #   "mac_address": "48:03:73:34:13:99",
    #   "management": false,
    #   "mtu": "",
    #   "netmask": "",
    #   "static": true,
    #   "static_routes": [],
    #   "virt_bridge": "xenbr0"
    # }
    mac_address: {
      type: 'Optional[String]',
      desc: 'MAC Address of the interface.',
      default: nil,
    },
    mtu: {
      type: 'Optional[Integer]',
      desc: 'MTU assigned to interface.',
      default: nil,
    },
    ip_address: {
      type: 'Optional[String]',
      desc: 'IPV4 address assigned to interface.',
      default: nil,
    },
    interface_type: {
      type: 'Optional[String]',
      desc: 'Interface type (na, bond, bridge, etc.)',
      default: nil,
    },
    interface_master: {
      type: 'Optional[String]',
      desc: 'Interface master, presumably for bonded or bridged interfaces.',
      default: nil,
    },
    bonding_opts: {
      type: 'Optional[String]',
      desc: 'Bond options for bonded interfaces.',
      default: nil,
    },
    bridge_opts: {
      type: 'Optional[String]',
      desc: 'Bond options for bonded interfaces.',
      default: nil,
    },
    management: {
      type: 'Optional[Boolean]',
      desc: 'Set as management interface.',
      default: nil,
    },
    static: {
      type: 'Optional[Boolean]',
      desc: 'Staticly configure interface.',
      default: nil,
    },
    netmask: {
      type: 'Optional[String]',
      desc: 'Subnet Mask.',
      default: nil,
    },
    if_gateway: {
      type: 'Optional[String]',
      desc: 'Per-interface gateway.',
      default: nil,
    },
    dhcp_tag: {
      type: 'Optional[String]',
      desc: 'DHCP tag.',
      default: nil,
    },
    dns_name: {
      type: 'Optional[String]',
      desc: 'DNS Name.',
      default: nil,
    },
    static_routes: {
      type: 'Optional[Variant[Array[String],String]]',
      desc: 'Static routes.',
      default: nil,
    },
    virt_bridge: {
      type: 'Optional[String]',
      desc: 'Virt bridge.',
      default: nil,
    },
    ipv6_address: {
      type: 'Optional[String]',
      desc: 'IPV6 Address.',
      default: nil,
    },
    ipv6_prefix: {
      type: 'Optional[String]',
      desc: 'IPV6 Prefix.',
      default: nil,
    },
    ipv6_secondaries: {
      type: 'Optional[Array[String]]',
      desc: 'IPV6 Secondaries.',
      default: nil,
    },
    ipv6_mtu: {
      type: 'Optional[Integer]',
      desc: 'IPV6 MTU.',
      default: nil,
    },
    ipv6_static_routes: {
      type: 'Optional[Array[String]]',
      desc: 'IPV6 Secondaries.',
      default: nil,
    },
    ipv6_default_gateway: {
      type: 'Optional[String]',
      desc: 'IPV6 Default Gateway.',
      default: nil,
    },
    cnames: {
      type: 'Optional[Array[String]]',
      desc: 'CNAMES.',
      default: nil,
    },
  },
  autorequires: {
    cobbler_system: '$system',
  }
)
