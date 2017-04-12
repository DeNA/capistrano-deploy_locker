require "spec_helper"

RSpec.describe Capistrano::DeployLocker do
  it "has a version number" do
    expect(Capistrano::DeployLocker::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
