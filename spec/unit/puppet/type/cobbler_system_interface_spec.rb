# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/cobbler_system_interface'

RSpec.describe 'the cobbler_system_interface type' do
  it 'loads' do
    expect(Puppet::Type.type(:cobbler_system_interface)).not_to be_nil
  end
end
