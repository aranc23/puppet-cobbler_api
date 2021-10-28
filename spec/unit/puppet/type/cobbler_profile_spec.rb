# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/cobbler_profile'

RSpec.describe 'the cobbler_profile type' do
  it 'loads' do
    expect(Puppet::Type.type(:cobbler_profile)).not_to be_nil
  end
end
