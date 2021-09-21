# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/cobbler_system'

RSpec.describe 'the cobbler_system type' do
  it 'loads' do
    expect(Puppet::Type.type(:cobbler_system)).not_to be_nil
  end
end
