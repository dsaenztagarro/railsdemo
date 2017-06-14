require 'byebug'

module DelayedExt
  module Priority
    class Plugin < Delayed::Plugin
      callbacks do |lifecycle|
        lifecycle.before(:enqueue) do |job|
          m = BebanjoJobs::PriorityManager.new
          j = BebanjoJobs::Job.wrap(job)
          job.priority = m.calculate_priority(job)
          Rails.logger.debug "Priority::Plugin priority: #{job.priority}"
        end
      end
    end
  end
end

Rails.logger.debug "Registering plugin DelayedExt::Priority::Plugin"

Delayed::Worker.plugins << DelayedExt::Priority::Plugin
