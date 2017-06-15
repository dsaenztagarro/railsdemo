class NestedJob
  def initialize(my_id)
    @my_id = my_id
  end

  def perform
    Rails.logger.debug("nested_job # perform #{@my_id}")
  end
end
