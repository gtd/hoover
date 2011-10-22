require 'hoover/rack_logger'
require 'hoover/job'
require 'hoover/railtie' if defined?(Rails)

module Hoover
  class << self
    def init(logglier = nil)
      self.active_job = Job.new(logglier)
    end

    def add(*args)
      active_job.add(*args)
    end

    def logglier=(logglier)
      active_job.logglier = logglier
    end

    def flush
      raise "Hoover.logglier must be set before calling flush" unless active_job.ready_to_post?

      active_job.post
      self.active_job = nil
    end

    private

    def active_job=(val)
      Thread.current[:active_hoover_job] = val
    end

    def active_job
      Thread.current[:active_hoover_job]
    end
  end
end
