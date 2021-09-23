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
    # General tab
    owners: {
      type: 'Variant[String,Array]',
      desc: 'Sets owners for the system.',
      default: '<<inherit>>',
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
    status: {
      type: 'String',
      desc: 'System status, production, development, testing, or acceptance.',
      default: 'production',
    },
    kernel_options: {
      type: 'Hash',
      desc: 'Hash of kernel options to be passed during install.',
      default: {},
    },
    kernel_options_post: {
      type: 'Hash',
      desc: 'Hash of kernel options to be used post install.',
      default: {},
    },
    autoinstall_meta: {
      type: 'Hash',
      desc: 'Hash of autoinstall (kickstart) metadata.',
      default: {},
    },
    boot_loader: {
      type: 'String',
      desc: 'The boot loader for the system (grub, pxelinux, yaboot, ipxe)',
      default: '<<inherit>>',
    },
    proxy: {
      type: 'String',
      desc: 'Internal proxy to use.',
      default: '<<inherit>>',
    },
    netboot_enable: {
      type: 'Optional[Boolean]',
      desc: 'Enable netboot.',
      behaviour: :init_only,
    },
    kickstart: {
      type: 'String',
      desc: 'Automatic installation template aka kickstart file.',
      default: '<<inherit>>',
    },
    comment: {
      type: 'String',
      desc: 'Cobbler system comment.',
      default: '',
    },
    # "Advanced Tab"
    enable_gpxe: {
      type: 'Boolean',
      desc: 'enable gPXE support',
      default: false,
    },
    server: {
      type: 'String',
      desc: ' gPXE server',
      default: '<<inherit>>',
    },
    next_server: {
      type: 'String',
      desc: ' gPXE next server',
      default: '<<inherit>>',
    },
    filename: {
      type: 'String',
      desc: ' gPXE file name override',
      default: '<<inherit>>',
    },
    # networking (global)
    hostname: {
      type: 'String',
      desc: 'The hostname of the system.',
      default: '',
    },
    gateway: {
      type: 'String',
      desc: 'network gateway address',
      default: '',
    },
    name_servers: {
      type: 'Array',
      desc: 'name server list',
      default: [],
    },
    name_servers_search: {
      type: 'Array',
      desc: 'name server domain search list',
      default: [],
    },
    ipv6_default_device: {
      type: 'String',
      desc: 'ipv6 default device',
      default: '',
    },
    ipv6_autoconfiguration: {
      type: 'Boolean',
      desc: 'enable ipv6 autoconf',
      default: false,
    },
    # interfaces: {
    #   type: 'Hash',
    #   desc: 'networking hash, as interpreted by the cobbler api',
    #   default: {},
    # },
  },
)
