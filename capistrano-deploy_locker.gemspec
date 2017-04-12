# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/deploy_locker/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-deploy_locker'
  spec.version       = Capistrano::DeployLocker::VERSION
  spec.authors       = ['progrhyme']

  spec.summary       = 'Capistrano Plugin to Lock Deployment'
  spec.description   = 'A capistrano 3 plugin which provides locking feature for deployment'
  spec.homepage      = 'https://github.com/DeNADev/capistrano-deploy_locker'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
