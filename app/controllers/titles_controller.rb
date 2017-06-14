require 'byebug'

class TitlesController < ApplicationController
  def index
    # TODO: extract `Delayed::Job.enqueue` so application is agnostic
    timestamp = Time.now.to_i
    Delayed::Job.enqueue MyFirstJob.new(timestamp), priority: 10
  end
end
