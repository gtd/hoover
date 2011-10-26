module Hoover
  class Railtie < Rails::Railtie
    def self.all_rails_log_subscribers
      [:action_controller, :action_mailer, :action_view, :active_resource, :active_record]
    end

    config.hoover = ActiveSupport::OrderedOptions.new
    config.hoover.log_subscribers = all_rails_log_subscribers

    initializer "hoover.add_rack_logger" do |app|
      app.middleware.insert_after Rails::Rack::Logger, Hoover::RackLogger
    end

    initializer "hoover.attach_log_subscribers" do |app|
      app.config.hoover.log_subscribers.each do |mod|
        "Hoover::#{mod.to_s.camelize}LogSubscriber".constantize.attach_to mod
      end
    end
  end
end

require 'hoover/action_controller_methods'
