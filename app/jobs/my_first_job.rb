class MyFirstJob
  def initialize(my_id)
    @my_id = my_id
  end

  def perform
    Rails.logger.debug("my_first_job # perform #{@my_id}")

    Delayed::Job.enqueue NestedJob.new(@my_id + 10_000)
  end
end
