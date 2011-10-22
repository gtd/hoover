# encoding: utf-8

require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end


require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "hoover"
  gem.homepage = "http://github.com/dasil003/hoover"
  gem.license = "MIT"
  gem.summary = %Q{Rack-based support for collecting a single hash per request to be sent to Loggly}
  gem.description = %Q{Sets up a hash at the beginning of each request and flushes it to Loggly at the end of the request.  Also comes with standard Rails 3 log subscribers.}
  gem.email = "gabe@websaviour.com"
  gem.authors = ["Gabe da Silveira"]
end
Jeweler::RubygemsDotOrgTasks.new


require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "spec"
  t.pattern = "spec/*_spec.rb"
end

task :default => :test
