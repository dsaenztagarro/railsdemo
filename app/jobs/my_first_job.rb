class MyFirstJob
  def initialize(my_id)
    @my_id = my_id
  end

  def perform
    Rails.logger.debug("my_first_job#perform #{@my_id}")
    # `touch /tmp/my_first_job_#{@my_id}.txt`
  end
end
