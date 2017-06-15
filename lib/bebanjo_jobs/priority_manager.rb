module BebanjoJobs
  class PriorityManager
    # @param job [BebanjoJobs::Job]
    def calculate_priority(job)
      if nested_job?
        cj = CurrentEnv.instance.current_job
        Rails.logger.debug("Current job: #{cj.class_name} (priority = #{cj.priority})")
        priority = cj.priority + 25
      else
        Rails.logger.debug("Request context: url:#{request_context.url}")
        if request_context.path_info.starts_with?('/api')
          if job.class_name.eql? "MyFirstJob"
            0
          else
            25
          end
        else
          if job.class_name.eql? "MyFirstJob"
            50
          else
            100
          end
        end
      end

      Rails.logger.debug("Nested job: #{job.class_name} (priority = #{priority})")
      priority
    end


    private

    def nested_job?
      !request_context
    end

    # @return [RequestContext]
    def request_context
      @request_context ||= CurrentEnv.instance.request_context
    end
  end
end
