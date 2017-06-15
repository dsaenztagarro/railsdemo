module BebanjoSidekiqExt
  module Priority
    class Server
      def call(worker, job, queue)
        puts "**** BebanjoSidekiqExt::Priority::Server"
        puts "TODO: CurrentEnv.instance.current_job = BebanjoJobs::Job.wrap(worker)"
        CurrentEnv.instance.current_job = BebanjoJobs::Job.wrap(job)
        puts worker
        puts job
        puts queue
        yield
      end
    end

    class Client
      def call(_worker_class, msg, queue, redis_pool = nil, &blk)
        Rails.logger.debug "**** BebanjoSidekiqExt::Priority::Client"
        m = BebanjoJobs::PriorityManager.new
        j = BebanjoJobs::Job.wrap(msg)
        priority = m.calculate_priority(j)
        msg["queue"] = "critical"
        Rails.logger.debug "Priority::Plugin class_name: #{j.class_name} priority: #{j.priority}"
        yield
      end
    end
  end
end

Rails.logger.debug "Registering middleware BebanjoSidekiqExt::Priority::Server"

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    chain.add BebanjoSidekiqExt::Priority::Client
  end
end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add BebanjoSidekiqExt::Priority::Server
  end
  config.client_middleware do |chain|
    chain.add BebanjoSidekiqExt::Priority::Client
  end
end
