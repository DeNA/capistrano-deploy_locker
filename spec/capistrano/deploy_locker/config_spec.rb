require 'spec_helper'

describe Capistrano::DeployLocker::Config do
  context 'Without configured values' do
    let(:config) { Capistrano::DeployLocker::Config.new }
    before :context do
      env = Capistrano::Configuration.env
      env.set(:application, 'test_app')
      env.set(:stage, 'test')
    end

    it 'Returns default values' do
      login = ENV['USER'] || ENV['LOGIN'] || Etc.getlogin || Etc.getpwuid.name
      expect(config.lock_key).to eq 'test_app.test'
      expect(config.lock_dir).to eq File.join(Dir.pwd, '.lock')
      expect(config.who).to eq login
      expect(config.why).to eq "#{$PROGRAM_NAME} #{ARGV.join(' ')}"
    end
  end

  context 'With configured values' do
    let(:config) { Capistrano::DeployLocker::Config.new }
    before :context do
      env = Capistrano::Configuration.env
      env.set(:deploy_lock_key, 'test_lock_key')
      env.set(:deploy_lock_dir, 'test_lock_dir')
      env.set(:deploy_lock_user, 'test_lock_user')
      env.set(:deploy_lock_reason, 'test_lock_reason')
    end

    it 'Returns configured values' do
      expect(config.lock_key).to eq 'test_lock_key'
      expect(config.lock_dir).to eq 'test_lock_dir'
      expect(config.who).to eq 'test_lock_user'
      expect(config.why).to eq 'test_lock_reason'
    end
  end
end
