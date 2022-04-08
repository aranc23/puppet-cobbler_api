# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'cobbler_profile',
  docs: <<-EOS,
@summary a cobbler_profile type
@example
cobbler_profile { 'foo':
  ensure => 'present',
}

This type provides Puppet with the capabilities to manage cobbler profiles

If your type uses autorequires, please document as shown below, else delete
these lines.
**Autorequires**:
* `Package[foo]`
EOS
  features: [],
  attributes: {
    ensure: {
      type: 'Enum[present, absent]',
      desc: 'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },
    name: {
      type: 'String',
      desc: 'The name of the profile.',
      behaviour: :namevar,
    },
    # General tab
    owners: {
      type: 'Optional[Variant[String,Array]]',
      desc: 'Sets owners for the system.',
      default: nil,
    },
    distro: {
      type: 'Optional[String]',
      desc: 'The distro associated with this profile.',
      default: nil,
    },
    parent: {
      type: 'Optional[String]',
      desc: 'The parent profile associated with this profile.',
      default: nil,
    },
    enable_menu: {
      type: 'Optional[Variant[Boolean,Integer,Enum["<<inherit>>"]]]',
      desc: 'Enable PXE Menu?',
      default: nil,
    },
    autoinstall: {
      type: 'Optional[String]',
      desc: 'Automatic installation template aka kickstart file.',
      default: nil,
    },
    kernel_options: {
      type: 'Optional[Variant[Hash,Enum["<<inherit>>"]]]',
      desc: 'Hash of kernel options to be passed during install.',
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
    proxy: {
      type: 'Optional[String]',
      desc: 'Internal proxy to use.',
      default: nil,
    },
    repos: {
      type: 'Optional[Variant[Array[String],String]]',
      desc: 'repos to use during install',
      default: nil,
    },
    comment: {
      type: 'Optional[String]',
      desc: 'Cobbler profile comment.',
      default: nil,
    },
    # "Advanced Tab"
    enable_gpxe: {
      type: 'Optional[Variant[Boolean,String,Integer]]',
      desc: 'enable gPXE support, can be inherited as well',
      default: nil,
    },
    dhcp_tag: {
      type: 'Optional[String]',
      desc: 'dhcp tag',
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
    boot_loaders: {
      type: 'Optional[Variant[Array[String],String]]',
      desc: 'array or string of boot_loaders',
      default: nil,
    },
  },
  autorequires: {
    cobbler_profile: '$parent',
  }
)
