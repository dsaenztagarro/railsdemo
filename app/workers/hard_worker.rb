class HardWorker
  include Sidekiq::Worker

  def perform(*args)
    Rails.logger.debug("hard_job # perform")
    puts CurrentEnv.instance.current_job
  end
end
