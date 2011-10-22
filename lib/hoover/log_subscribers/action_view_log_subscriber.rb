module Hoover
  class ActionViewLogSubscriber < ActiveSupport::LogSubscriber
    def render_template(event)
      rendered = { :identifier => from_rails_root(event.payload[:identifier]),
                   :duration => event.duration }
      rendered[:layout] = from_rails_root(event.payload[:layout]) if event.payload[:layout]

      Hoover.add :rendered => rendered
    end
    alias :render_partial :render_template
    alias :render_collection :render_template

  protected

    def from_rails_root(string)
      string.sub("#{Rails.root}/", "").sub(/^app\/views\//, "")
    end
  end
end
