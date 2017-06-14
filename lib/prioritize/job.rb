module Prioritize
  class Job
    attr_reader :priority

    def initialize(priority)
      @priority = priority
    end

    def self.wrap(job)
      case job
      when Delayed::Backend::ActiveRecord::Job then new(job.priority)
      end
    end
  end
end
