require 'helper'
require 'rails'

describe Hoover::ActionControllerLogSubscriber do
  before do
    Hoover.init
    @subscriber = Hoover::ActionControllerLogSubscriber.new
  end

  describe "start_processing" do
    before do
      @subscriber.start_processing(start_processing_stub)
    end

    it "sets controller" do
      Hoover.hash[:controller].first.must_equal "AboutController"
    end

    it "sets action" do
      Hoover.hash[:action].first.must_equal "index"
    end

    it "sets params" do
      Hoover.hash[:params].first.must_equal "with_param" => "1"
    end

    it "sets format" do
      Hoover.hash[:format].first.must_equal "HTML"
    end
  end

  describe "process_action" do
    before do
      @subscriber.process_action(process_action_stub)
    end

    it "sets status" do
      Hoover.hash[:status].first.must_equal 200
    end

    it "sets duration" do
      Hoover.hash[:duration].first.must_equal 475.987
    end

    it "sets runtimes" do
      Hoover.hash[:runtimes].first.must_equal "Views" => 138.4
    end
  end

  describe "send_file" do
    before do
      @subscriber.send_file(send_file_stub)
    end

    it "sets sent_file" do
      Hoover.hash[:sent_file].first.must_equal :path => '/apath', :runtime => 100.1
    end
  end

  describe "redirect_to" do
    before do
      @subscriber.redirect_to(redirect_to_stub)
    end

    it "sets sent_file" do
      Hoover.hash[:redirected_to].first.must_equal '/newlocation'
    end
  end

  describe "send_data" do
    before do
      @subscriber.send_data(send_data_stub)
    end

    it "sets sent_data" do
      Hoover.hash[:sent_data].first.must_equal :filename => 'somefile.txt', :runtime => 200.1
    end
  end

  describe "write_fragment" do
    before do
      @subscriber.write_fragment(fragment_stub)
    end

    it "sets write_fragment" do
      Hoover.hash[:write_fragment].first.must_equal :key => 'thefrag', :runtime => 123.1
    end
  end

  describe "read_fragment" do
    before do
      @subscriber.read_fragment(fragment_stub)
    end

    it "sets read_fragment" do
      Hoover.hash[:read_fragment].first.must_equal :key => 'thefrag', :runtime => 123.1
    end
  end

  describe "exist_fragment" do
    before do
      @subscriber.exist_fragment?(fragment_stub)
    end

    it "sets exist_fragment" do
      Hoover.hash[:exist_fragment?].first.must_equal :key => 'thefrag', :runtime => 123.1
    end
  end

  describe "expire_fragment" do
    before do
      @subscriber.expire_fragment(fragment_stub)
    end

    it "sets expire_fragment" do
      Hoover.hash[:expire_fragment].first.must_equal :key => 'thefrag', :runtime => 123.1
    end
  end

  describe "expire_page" do
    before do
      @subscriber.expire_page(page_stub)
    end

    it "sets expire_page" do
      Hoover.hash[:expire_page].first.must_equal :key => '/thepath', :runtime => 124.1
    end
  end

  private

  def start_processing_stub
    payload = { :controller => "AboutController", :action => "index", :path => "/about?with_param=1",
                 :params => { "with_param" => "1", "action" => "index", "controller" => "about" },
                 :formats => [:html], :method=>"GET" }
    duration = 0.005
    stub(:payload => payload, :duration => duration)
  end

  def process_action_stub
    payload = { :controller => "AboutController", :action => "index", :status => 200,
                 :params => { "with_param" => "1", "action" => "index", "controller" => "about" },
                 :path => "/about?with_param=1", :formats => [:html], :method => "GET",
                 :query_runtime => 0, :db_runtime => 4.542, :view_runtime => 138.39879927063 }
    duration = 475.987
    stub(:payload => payload, :duration => duration)
  end

  def send_file_stub
    payload = { :path => '/apath' }
    duration = 100.1
    stub(:payload => payload, :duration => duration)
  end

  def redirect_to_stub
    payload = { :location => '/newlocation' }
    stub(:payload => payload)
  end

  def send_data_stub
    payload = { :filename => 'somefile.txt' }
    duration = 200.1
    stub(:payload => payload, :duration => duration)
  end

  def fragment_stub
    payload = { :key => 'thefrag' }
    duration = 123.1
    stub(:payload => payload, :duration => duration)
  end

  def page_stub
    payload = { :path => '/thepath' }
    duration = 124.1
    stub(:payload => payload, :duration => duration)
  end
end
