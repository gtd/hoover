require 'helper'
require 'rails'

describe Hoover::ActionMailerLogSubscriber do
  before do
    Hoover.init
    @subscriber = Hoover::ActionMailerLogSubscriber.new
  end

  describe 'deliver' do
    before do
      @subscriber.deliver(deliver_stub)
    end

    it "sets sent_mail_to" do
      Hoover.hash[:sent_mail_to].first.must_equal ['email@example.com']
    end
  end
  private

  def deliver_stub
    payload = { :to => 'email@example.com' }
    duration = 1.1
    stub(:payload => payload, :duration => duration)
  end
end
