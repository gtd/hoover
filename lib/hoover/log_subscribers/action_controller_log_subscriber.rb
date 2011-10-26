require 'action_controller'
require 'active_support/core_ext/hash/except'

module Hoover
  class ActionControllerLogSubscriber < ActiveSupport::LogSubscriber
    INTERNAL_PARAMS = %w(controller action format _method only_path)

    def start_processing(event)
      payload = event.payload
      params  = payload[:params].except(*INTERNAL_PARAMS)

      Hoover.add(:controller => payload[:controller],
                 :action => payload[:action],
                 :params => params,
                 :format => payload[:formats].first.to_s.upcase)
    end

    def process_action(event)
      payload   = event.payload
      additions = ActionController::Base.log_process_action(payload)

      runtimes  = additions.inject({}) do |hash, string|
        name, time = string.split(':')
        hash[name] = time.to_f
        hash
      end

      status = payload[:status]
      if status.nil? && payload[:exception].present?
        status = Rack::Utils.status_code(ActionDispatch::ShowExceptions.rescue_responses[payload[:exception].first]) rescue nil
      end

      Hoover.add(:status => status,
                 :duration => event.duration)
      Hoover.add :runtimes => runtimes unless runtimes.blank?
    end

    def send_file(event)
      Hoover.add(:sent_file => { :path => event.payload[:path], :runtime => event.duration })
    end

    def redirect_to(event)
      Hoover.add(:redirected_to => event.payload[:location])
    end

    def send_data(event)
      Hoover.add(:sent_data => { :filename => event.payload[:filename], :runtime => event.duration })
    end

    %w(write_fragment read_fragment exist_fragment?
       expire_fragment expire_page write_page).each do |method|
      class_eval <<-METHOD, __FILE__, __LINE__ + 1
        def #{method}(event)
          key_or_path = event.payload[:key] || event.payload[:path]
          Hoover.add(#{method.to_sym.inspect} => { :key => key_or_path, :runtime => event.duration })
        end
      METHOD
    end
  end
end
