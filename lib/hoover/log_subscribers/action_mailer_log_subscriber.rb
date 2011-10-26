module Hoover
  class ActionMailerLogSubscriber < ActiveSupport::LogSubscriber
    def deliver(event)
      recipients = Array.wrap(event.payload[:to])
      Hoover.add(:sent_mail_to => recipients)
      Hoover.add(:sent_mail_duration => event.duration)
    end
  end
end
