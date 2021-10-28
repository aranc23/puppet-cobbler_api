# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/cobbler_repo'

RSpec.describe 'the cobbler_repo type' do
  it 'loads' do
    expect(Puppet::Type.type(:cobbler_repo)).not_to be_nil
  end
end
