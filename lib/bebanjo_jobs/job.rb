module BebanjoJobs
  class Job
    attr_reader :priority, :class_name

    def initialize(class_name:, priority:)
      @class_name = class_name
      @priority = priority
    end

    def self.wrap(job)
      case job
      when Delayed::Backend::ActiveRecord::Job
        new(priority: job.priority, class_name: job.payload_object.class.name)
      when Hash
        new(priority: adapt_queue_to_i(job["queue"]), class_name: job["class_name"])
      end
    end

    def self.adapt_queue_to_i(queue)
      22
    end
  end
end
