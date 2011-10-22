module Hoover
  class ActiveResourceLogSubscriber < ActiveSupport::LogSubscriber
    def request(event)
      result = event.payload[:result]
      request = { :method => event.payload[:method].to_s.upcase,
                  :request_uri => event.payload[:request_uri],
                  :result_code => result.code,
                  :result_message => result.message,
                  :result_length => result.body.to_s.length,
                  :duration => event.duration }
      Hoover.add(:active_resource_request => request)
    end
  end
end
