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
      desc: 'The name of the system.',
      behaviour: :namevar,
    },
    # General tab
    owners: {
      type: 'Optional[Variant[String,Array]]',
      desc: 'Sets owners for the system.',
      default: nil,
    },
    profile: {
      type: 'Optional[String]',
      desc: 'The profile associated with this system.',
      default: nil,
    },
    image: {
      type: 'Optional[String]',
      desc: 'The image associated with this system.',
      default: nil,
    },
    status: {
      type: 'Optional[String]',
      desc: 'System status, production, development, testing, or acceptance.',
      default: nil,
    },
    kernel_options: {
      type: 'Optional[Variant[Hash,Enum["<<inherit>>"]]]',
      desc: 'Hash of kernel options to be passed during install, or <<inherit>>',
      default: nil,
    },
    kernel_options_post: {
      type: 'Optional[Variant[Hash,Enum["<<inherit>>"]]]',
      desc: 'Hash of kernel options to be used post install.',
      default: nil,
    },
    autoinstall_meta: {
      type: 'Optional[Variant[Hash,Enum["<<inherit>>"]]]',
      desc: 'Hash of autoinstall (kickstart) metadata.',
      default: nil,
    },
    boot_loader: {
      type: 'Optional[String]',
      desc: 'The boot loader for the system (grub, pxelinux, yaboot, ipxe)',
      default: nil,
    },
    proxy: {
      type: 'Optional[String]',
      desc: 'Internal proxy to use.',
      default: nil,
    },
    netboot_enabled: {
      type: 'Optional[Boolean]',
      desc: 'Enable netboot, on creation false is set unless this option is set otherwise.',
      default: false,
      behaviour: :init_only,
    },
    autoinstall: {
      type: 'Optional[String]',
      desc: 'Automatic installation template aka kickstart file.',
      default: nil,
    },
    comment: {
      type: 'Optional[String]',
      desc: 'Cobbler system comment.',
      default: nil,
    },
    # "Advanced Tab"
    enable_gpxe: {
      type: 'Optional[Variant[Boolean,String,Integer]]',
      desc: 'enable gPXE support, can be inherited as well',
      default: nil,
    },
    server: {
      type: 'Optional[String]',
      desc: ' gPXE server',
      default: nil,
    },
    next_server: {
      type: 'Optional[String]',
      desc: ' gPXE next server',
      default: nil,
    },
    filename: {
      type: 'Optional[String]',
      desc: ' gPXE file name override',
      default: nil,
    },
    # networking (global)
    hostname: {
      type: 'Optional[String]',
      desc: 'The hostname of the system.',
      default: nil,
    },
    gateway: {
      type: 'Optional[String]',
      desc: 'network gateway address',
      default: nil,
    },
    name_servers: {
      type: 'Optional[Variant[Array[String],String]]',
      desc: 'name server list',
      default: nil,
    },
    name_servers_search: {
      type: 'Optional[Variant[Array[String],String]]',
      desc: 'name server domain search list',
      default: nil,
    },
    ipv6_default_device: {
      type: 'Optional[String]',
      desc: 'ipv6 default device',
      default: nil,
    },
    ipv6_autoconfiguration: {
      type: 'Optional[Boolean]',
      desc: 'enable ipv6 autoconf',
      default: nil,
    },
    # interfaces: {
    #   type: 'Hash',
    #   desc: 'networking hash, as interpreted by the cobbler api',
    #   default: {},
    # },
  },
  autorequires: {
    cobbler_profile: '$profile',
  }
)
