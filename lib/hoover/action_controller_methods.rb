module Hoover
  module ActionControllerMethods
    def set_hoover_logglier(logglier)
      before_filter do
        if Hoover.initialized?
          Hoover.logglier = logglier
        else
          Hoover.init(logglier)
        end
      end
    end
  end
end

ActionController::Base.extend(Hoover::ActionControllerMethods)
