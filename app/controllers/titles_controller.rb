class TitlesController < ApplicationController
  def index
    # TODO: extract `Delayed::Job.enqueue` so application is agnostic
    timestamp = Time.now.to_i
    if params["delayedjob"]
      Delayed::Job.enqueue MyFirstJob.new(timestamp), priority: 10
    else
      HardWorker.perform_async(timestamp)
    end
  end
end
