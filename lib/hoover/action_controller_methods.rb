module Hoover
  module ActionControllerMethods
    def set_hoover_logglier(logglier)
      before_filter { Hoover.logglier = logglier }
    end
  end
end

ActionController::Base.extend(Hoover::ActionControllerMethods)
