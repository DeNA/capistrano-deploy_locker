require 'capistrano/deploy_locker/base'

namespace :deploy do
  namespace :lock do
    task :check do
      Capistrano::DeployLocker.locked?
    end

    task :create do
      begin
        Capistrano::DeployLocker.lock
      rescue Capistrano::DeployLocker::AlreadyLocked => e
        puts "ERROR! #{e}"
        exit(1)
      end
    end

    task :clear do
      Capistrano::DeployLocker.unlock
    end
  end

  desc 'Get lock for Deploy operation'
  task :lock do
    invoke 'deploy:lock:create'
  end

  desc 'Release lock for Deploy operation'
  task :unlock do
    invoke 'deploy:lock:clear'
  end
end
