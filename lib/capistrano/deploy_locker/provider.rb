require 'capistrano/deploy_locker/base'

class Capistrano::DeployLocker::Provider
  def initialize(config = Capistrano::DeployLocker.config)
    @config = config
    FileUtils.mkpath(config.lock_dir)
  end

  def locked?
    locked = false
    File.open(lock_file, File::RDWR | File::CREAT, 0o0644) do |f|
      locked = true unless f.flock(File::LOCK_EX | File::LOCK_NB)
    end
    locked
  end

  def create
    @lock_file = File.open(lock_file, File::RDWR | File::CREAT, 0o0644)
    unless @lock_file.flock(File::LOCK_EX | File::LOCK_NB)
      @lock_file.close
      message = "#{lock_file} is already locked!\n"
      if i = info
        message << "Info: #{i}"
      else
        message << 'No additional info available.'
      end
      raise Capistrano::DeployLocker::AlreadyLocked, message
    end
    update_info
  end

  def clear
    @lock_file.flock(File::LOCK_UN | File::LOCK_NB)
    @lock_file.close
  end

  def info
    return unless File.readable?(info_file)
    JSON.parse(File.read(info_file))
  end

  def update_info
    content = {
      user: @config.who,
      reason: @config.why,
      date: Time.now,
    }.to_json
    File.write(info_file, "#{content}\n")
  end

  private

  def lock_file
    File.join(@config.lock_dir, "#{@config.lock_key}.lock")
  end

  def info_file
    File.join(@config.lock_dir, "#{@config.lock_key}.info")
  end
end
