require 'helper'

describe Hoover do
  after { Hoover.reset! }

  describe "unitialized" do
    it "should not allow add" do
      proc{ Hoover.add(:key => 'val') }.must_raise RuntimeError, "Must init Hoover before calling add"
    end

    it "should not allow setting logglier" do
      proc{ Hoover.logglier = nil }.must_raise RuntimeError, "Must init Hoover before setting logglier"
    end
  end

  describe "initialized wo logglier" do
    before { Hoover.init }

    it "should allow add" do
      Hoover::Job.any_instance.expects(:add).with({})
      Hoover.add({})
    end

    it "should allow setting logglier" do
      logglier = Object.new
      (Hoover.logglier = logglier).must_equal logglier
    end

    it "should not allow flushing" do
      proc{ Hoover.flush }.must_raise RuntimeError, "Hoover.logglier must be set before calling flush"
    end
  end

  describe "initialized with logglier" do
    before do
      @logglier = Object.new
      Hoover.init(@logglier) 
    end

    it "should allow add" do
      Hoover::Job.any_instance.expects(:add).with({})
      Hoover.add({})
    end

    it "should allow setting logglier" do
      logglier = Object.new
      (Hoover.logglier = logglier).must_equal logglier
    end

    it "should allow flush" do
      Hoover::Job.any_instance.expects(:post)
      Hoover.flush
    end
  end
end
