# encoding: utf-8
require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "hoover"
  gem.homepage = "http://github.com/dasil003/hoover"
  gem.license = "MIT"
  gem.summary = %Q{Rack-based support for collecting a single hash per request to be sent to Loggly}
  gem.description = %Q{Sets up a hash at the beginning of each request and flushes it to Loggly at the end of the request.  Also comes with standard Rails 3 log subscribers.}
  gem.email = "gabe@websaviour.com"
  gem.authors = ["Gabe da Silveira"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new
