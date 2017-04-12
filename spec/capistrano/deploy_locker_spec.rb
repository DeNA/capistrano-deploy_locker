require 'spec_helper'

describe Capistrano::DeployLocker do
  it 'has a version number' do
    expect(Capistrano::DeployLocker::VERSION).not_to be nil
  end
end
