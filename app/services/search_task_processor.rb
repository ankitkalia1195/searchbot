class SearchTaskProcessor
  attr_reader :search_task

  def initialize(search_task_id)
    @search_task = SearchTask.find_by(id: search_task_id)
  end

  def perform

  end

end
