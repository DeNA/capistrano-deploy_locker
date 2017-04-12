[![Gem Version](https://badge.fury.io/rb/capistrano-deploy_locker.svg)](https://badge.fury.io/rb/capistrano-deploy_locker)
[![Build Status](https://travis-ci.org/DeNADev/capistrano-deploy_locker.svg?branch=master)](https://travis-ci.org/DeNADev/capistrano-deploy_locker)
# Capistrano::DeployLocker

A capistrano plugin to make deployment with exclusive lock.

In other words, this protects any two processes from running `cap deploy`
command at the same time.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-deploy_locker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-deploy_locker


## Configuration

Set Capistrano variables with `set name, value`.

Name | Default | Description
-----|---------|------------
deploy_lock_key |  `"#{fetch(:application)}.#{fetch(:stage)}"` | String to specify lock target
deploy_lock_dir | `./.lock` | Directory to write lockfile or other info
deploy_lock_user | `ENV['USER'] || ENV['LOGIN']` | Who locks deploy
deploy_lock_reason | `"#{$0} #{ARGV}"` | Why deploy is locked

You can provide `:deploy_lock_user` and `:deploy_lock_reason` to show infomation
of your deployment for other operators who try to get lock in fail.

## Usage

Edit Capfile:

```ruby
# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Includes tasks from other gems included in your Gemfile
require 'capistrano/deploy_locker'
```

Edit your `config/deploy.rb`:

```ruby
before 'deploy:starting', 'deploy:lock'
after 'deploy:finished', 'deploy:unlock'
after 'deploy:failed', 'deploy:unlock'
```

## License

Available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Copyright (c) 2017 DeNA Co., Ltd., IKEDA Kiyoshi

