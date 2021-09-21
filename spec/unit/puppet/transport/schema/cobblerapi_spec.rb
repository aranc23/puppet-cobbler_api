# frozen_string_literal: true

require 'spec_helper'
require 'puppet/transport/schema/cobblerapi'

RSpec.describe 'the cobblerapi transport' do
  it 'loads' do
    expect(Puppet::ResourceApi::Transport.list['cobblerapi']).not_to be_nil
  end
end
