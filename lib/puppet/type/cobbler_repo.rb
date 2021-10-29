# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'cobbler_repo',
  docs: <<-EOS,
@summary a cobbler_repo type
@example
cobbler_repo { 'foo':
  ensure => 'present',
  mirror => 'http://example.com/mirror',
  breed  => 'yum',
  keep_updated => true,
  mirror_locally => true,
}

This type provides Puppet with the capabilities to manage cobbler repos

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
      desc: 'The name of the resource you want to manage.',
      behaviour: :namevar,
    },
    # General tab
    owners: {
      type: 'Optional[Variant[String,Array]]',
      desc: 'Sets owners for the system.',
      default: nil,
    },
    arch: {
      type: 'Optional[String]',
      desc: 'Architecture, should be an enum',
      default: nil,
    },
    breed: {
      type: 'Optional[String]',
      desc: 'breed, should be an enum of yum, etc.',
      default: nil,
    },
    keep_updated: {
      type: 'Optional[Boolean]',
      desc: 'Keep Updated?',
      default: nil,
    },
    mirror: {
      type: 'Optional[String]',
      desc: 'the path to the resource to mirror into this repo',
    },
    rpm_list: {
      type: 'Optional[Variant[Array[String],String]]',
      desc: 'list of rpms for what purpose I know not',
      defaults: nil,
    },
    comment: {
      type: 'Optional[String]',
      desc: 'Cobbler repo comment.',
      default: nil,
    },
    proxy: {
      type: 'Optional[String]',
      desc: 'Internal proxy to use, this seems to be a hidden option in the current version',
      default: nil,
    },

    # advanced tab:
    apt_components: {
      type: 'Optional[String]',
      desc: 'Apt Components (apt only)',
      default: nil,
    },
    apt_dists: {
      type: 'Optional[String]',
      desc: 'Apt Dist Names (apt only)',
      default: nil,
    },
    createrepo_flags: {
      type: 'Optional[String]',
      desc: 'Createrepo Flags',
      default: nil,
    },
    environment: {
      type: 'Optional[Hash]',
      desc: 'Hash of environment variables',
      default: nil,
    },
    mirror_locally: {
      type: 'Optional[Boolean]',
      desc: 'Mirror Locally?',
      default: nil,
    },
    priority: {
      type: 'Optional[Integer]',
      desc: 'repo priority',
      default: nil,
    },
    yumopts: {
      type: 'Optional[Hash]',
      desc: 'Hash of yum options',
      default: nil,
    },
    rsyncopts: {
      type: 'Optional[Hash]',
      desc: 'Hash of rsync options',
      default: nil,
    },
  },
)
