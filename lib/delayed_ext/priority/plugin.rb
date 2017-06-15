module DelayedExt
  module Priority
    class Plugin < Delayed::Plugin
      callbacks do |lifecycle|
        lifecycle.before(:enqueue) do |job|
          m = BebanjoJobs::PriorityManager.new
          j = BebanjoJobs::Job.wrap(job)
          job.priority = m.calculate_priority(j)
          Rails.logger.debug "Priority::Plugin class_name: #{j.class_name} priority: #{j.priority}"
        end

        lifecycle.before(:invoke_job) do |job|
          CurrentEnv.instance.current_job = BebanjoJobs::Job.wrap(job)
        end
      end
    end
  end
end

Rails.logger.debug "Registering plugin DelayedExt::Priority::Plugin"

Delayed::Worker.plugins << DelayedExt::Priority::Plugin
