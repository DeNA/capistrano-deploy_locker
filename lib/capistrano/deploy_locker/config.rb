require 'capistrano/deploy_locker/base'

class Capistrano::DeployLocker::Config
  extend ::Forwardable
  def_delegator :@env, :fetch

  def initialize(env = Capistrano::Configuration.env)
    @env = env
  end

  def lock_key
    @lock_key ||= fetch(:deploy_lock_key, nil)
    @lock_key ||= [fetch(:application), fetch(:stage)].join('.')
  end

  def lock_dir
    @lock_dir ||= fetch(:deploy_lock_dir, File.join(Dir.pwd, '.lock'))
  end

  def who
    @who ||= fetch(:deploy_lock_user, ENV['USER'] || ENV['LOGIN'] || Etc.getlogin || Etc.getpwuid.name)
  end

  def why
    @why ||= fetch(:deploy_lock_reason, "#{$PROGRAM_NAME} #{ARGV.join(' ')}")
  end
end
