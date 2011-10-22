module Hoover
  class Job
    attr_writer :logglier
    attr_reader :hash

    def initialize(logglier = nil)
      @logglier = logglier
      @hash = {}
    end

    def add(hash)
      hash.each do |k,v|
        if @hash.key?(k)
          @hash[k] << v
        else
          @hash[k] = [v]
        end
      end
    end

    def ready_to_post?
      ! @logglier.nil?
    end

    def post
      raise "cannot post until logglier is set" unless ready_to_post?
      @hash.each{ |k,v| @hash[k] = @hash[k].first if v.size == 1 }
      @logglier.info(@hash)
    end
  end
end
