require 'spec_helper'

describe Capistrano::DeployLocker::Provider do
  let(:env) { Capistrano::Configuration.env }

  before :each do
    env.set(:deploy_lock_key, 'test_provider')
    env.set(:deploy_lock_dir, File.join(Dir.pwd, 'tmp'))
  end

  describe 'Lock features' do
    let(:provider) { Capistrano::DeployLocker::Provider.new }
    subject { provider.locked? }

    context 'Before locked' do
      it '#locked? returns false' do
        expect(subject).to be false
      end
    end

    context 'After locked' do
      before :each do
        provider.create
      end

      after :each do
        provider.clear
      end

      it '#locked? returns true' do
        expect(subject).to be true
      end
    end

    context 'After the lock is cleared' do
      before :each do
        provider.create
        provider.clear
      end

      it '#locked? returns false' do
        expect(subject).to be false
      end
    end
  end
end
