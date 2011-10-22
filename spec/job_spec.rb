require 'helper'

describe Hoover::Job do
  before do
    @logglier = Object.new
    @job = Hoover::Job.new(@logglier)
  end

  describe "adding one item" do
    before { @job.add(:foo => 'bar') }

    it "populates the hash" do
      @job.hash.must_equal :foo => ['bar']
    end

    it "wraps the single item in an array" do
      @job.hash[:foo].must_be_instance_of Array
    end
  end

  describe "adding multiple keys" do
    before do
      @job.add(:foo => 'bar')
      @job.add(:bar => 'baz')
    end

    it "saves both keys" do
      @job.hash.must_equal :foo => ['bar'], :bar => ['baz']
    end
  end

  describe "adding repeating keys" do
    before do
      @job.add(:foo => 'bar')
      @job.add(:foo => 'baz')
    end

    it "appends to the array" do
      @job.hash.must_equal :foo => ['bar', 'baz']
    end
  end

  describe "adding an array" do
    before do
      @job.add(:foo => ['bar', 'baz'])
    end

    it "wraps with an outer array" do
      @job.hash.must_equal :foo => [['bar', 'baz']]
    end
  end

  describe "with singular and multiple keys" do
    before do
      @job.add(:string => 'string', :array => %w(a r r a y), :hash => {:foo => 'bar'},
               :strings => 'string1', :arrays => %w(a ray), :hashes => {:bar => 'baz'})
      @job.add(:strings => 'string2', :arrays => %w(another ray), :hashes => {:baz => 'boom'})
    end

    it "unwraps them before posting" do
      expected = { :string => 'string',
                   :strings => ['string1', 'string2'],
                   :array => ['a', 'r', 'r', 'a', 'y'],
                   :arrays => [['a', 'ray'], ['another', 'ray']],
                   :hash => {:foo => 'bar'},
                   :hashes => [{:bar => 'baz'}, {:baz => 'boom'}] }
      @logglier.expects(:info).with(expected)
      @job.post
    end
  end
end
