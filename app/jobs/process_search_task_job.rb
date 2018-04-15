class ProcessSearchTaskJob < ApplicationJob
  queue_as :default

  def perform(search_task)
    search_task.process!
  end
end
