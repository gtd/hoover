module Hoover
  class RackLogger
    def initialize(app, logglier = nil)
      @logglier = logglier
      @app = app
    end

    def call(env)
      before_dispatch(env)
      @app.call(env)
    ensure
      after_dispatch(env)
    end

    protected

    def before_dispatch(env)
      Hoover.init @logglier

      if defined? ActionDispatch::Request
        request = ActionDispatch::Request.new(env)
        Hoover.add :method => request.request_method,
                   :path => request.filtered_path
      else
        # TODO: Figure out sane logging defaults for the average rack app and make this configurable
        Hoover.add env
      end

      Hoover.add :ip => request.ip,
                 :started_at => Time.now.utc
    end

    def after_dispatch(env)
      # FIXME: Hoover is often not ready to post, if the before_filter that sets the logglier instance
      #        hasn't run.  Examples are routing redirects.  This will be fixed by proper logglier configuration
      Hoover.flush if Hoover.ready_to_post?
    end
  end
end
