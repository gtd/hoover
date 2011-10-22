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

      status = payload[:status]
      if status.nil? && payload[:exception].present?
        status = Rack::Utils.status_code(ActionDispatch::ShowExceptions.rescue_responses[payload[:exception].first]) rescue nil
      end

      Hoover.add(:status => "#{status} #{Rack::Utils::HTTP_STATUS_CODES[status]}",
                 :duration => "%.0f" % event.duration)
      Hoover.add :additions => additions.join(" | ") unless additions.blank?
    end

    def send_file(event)
      Hoover.add(:sent_file, "%s (%.1fms)" % [event.payload[:path], event.duration])
    end

    def redirect_to(event)
      Hoover.add(:redirected_to, event.payload[:location])
    end

    def send_data(event)
      Hoover.add(:sent_data, "%s (%.1fms)" % [event.payload[:filename], event.duration])
    end

    %w(write_fragment read_fragment exist_fragment?
       expire_fragment expire_page write_page).each do |method|
      class_eval <<-METHOD, __FILE__, __LINE__ + 1
        def #{method}(event)
          key_or_path = event.payload[:key] || event.payload[:path]
          human_name  = #{method.to_s.humanize.inspect}
          Hoover.add(method.to_sym, "\#{key_or_path} (%.1fms)" % event.duration)
        end
      METHOD
    end
  end
end
