module BebanjoJobs
  class PriorityManager
    def calculate_priority(job)
      if request_context.path_info.starts_with?('/api')
        0
      else
        100
      end
    end

    private

    # @return [RequestContext]
    def request_context
      @request_context ||= CurrentEnv.instance.request_context
    end
  end
end
