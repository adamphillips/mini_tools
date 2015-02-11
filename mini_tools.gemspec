# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'mini_tools/version'

Gem::Specification.new do |s|
  s.name        = 'mini_tools'
  s.version     = MiniTools::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.summary     = "A simple set of lightweight tools"
  s.email       = "adam@29ways.co.uk"
  s.homepage    = "https://github.com/adamphillips/mini_tools"
  s.description = "A set of simple lightweight tools"
  s.authors     = ['Adam Phillips']
  s.license     = "MIT"

  s.files         = Dir["README.md", "lib/**/*"]
  s.test_files    = Dir["spec/**/*.rb"]
  s.require_paths = ["lib"]

  s.add_development_dependency 'minitest'
end
