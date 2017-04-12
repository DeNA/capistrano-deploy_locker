require 'fileutils'
require 'forwardable'
require 'json'
require 'capistrano/configuration'

module Capistrano
  module DeployLocker
    require 'capistrano/deploy_locker/provider'
    require 'capistrano/deploy_locker/config'
    require 'capistrano/deploy_locker/version'

    class << self
      extend ::Forwardable
      def_delegator :provider, :locked?
      def_delegator :provider, :create, :lock
      def_delegator :provider, :clear, :unlock
    end

    class AlreadyLocked < ::StandardError; end

    def self.provider
      @provider ||= Capistrano::DeployLocker::Provider.new
    end

    def self.config
      @config ||= Capistrano::DeployLocker::Config.new
    end
  end
end
