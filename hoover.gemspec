$:.push File.expand_path("../lib", __FILE__)  
require "hoover/version"

Gem::Specification.new do |s|
  s.name = 'hoover'
  s.version = Hoover::VERSION
  s.authors = ['Gabe da Silveira']
  s.email = ['gabe@websaviour.com']
  s.summary = %q{Rack-based support for collecting a single hash per request to be sent to Loggly}
  s.description = %q{Sets up a hash at the beginning of each request and flushes it to Loggly at the end of the request.  Also comes with standard Rails 3 log subscribers.}
  s.homepage = %q{http://github.com/gtd/hoover}
  s.licenses = [%q{MIT}]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.require_paths = [%q{lib}]

  s.add_dependency "logglier", ["~> 0.2.5"]

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "minitest"
  s.add_development_dependency "mocha"
  s.add_development_dependency "rails", ["~> 3.1.0"]
end
