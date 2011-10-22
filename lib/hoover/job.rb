module Hoover
  class Job
    attr_writer :logglier

    def initialize(logglier = nil)
      @logglier = logglier
      @hash = {}
    end

    def add(hash)
      hash.each do |k,v|
        if @hash.key?(k)
          if @hash[k].is_a?(Array)
            @hash[k] << v
          else
            @hash[k] = [@hash[k], v]
          end
        else
          @hash[k] = v
        end
      end
    end

    def ready_to_post?
      ! @logglier.nil?
    end

    def post
      @logglier.info(@hash)
    end
  end
end
