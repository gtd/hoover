require 'helper'
require 'rails'

describe Hoover::ActiveResourceLogSubscriber do
  before do
    Hoover.init
    @subscriber = Hoover::ActiveResourceLogSubscriber.new
  end

  describe 'request' do
    before do
      @subscriber.request(request_stub)
    end

    it "sets method" do
      Hoover.hash[:active_resource_request].first[:method].must_equal 'GET'
    end

    it "sets request_uri" do
      Hoover.hash[:active_resource_request].first[:request_uri].must_equal 'http://localhost/test.xml'
    end

    it "sets result_code" do
      Hoover.hash[:active_resource_request].first[:result_code].must_equal 200
    end

    it "sets result_message" do
      Hoover.hash[:active_resource_request].first[:result_message].must_equal 'OK'
    end

    it "sets result_length" do
      Hoover.hash[:active_resource_request].first[:result_length].must_equal 4
    end

    it "sets duration" do
      Hoover.hash[:active_resource_request].first[:duration].must_equal 21.12
    end
  end
  private

  def request_stub
    result = stub(:code => '200', :message => 'OK', :body => 'body')
    payload = { :method => :get, :result => result, :request_uri => "http://localhost/test.xml" }
    duration = 21.12
    stub(:payload => payload, :duration => duration)
  end
end
