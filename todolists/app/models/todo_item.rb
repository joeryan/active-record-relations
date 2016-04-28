class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  default_scope { order("due_date asc") }

  def self.completed_todo_items
    completed_count = self.where(completed: true).count
  end

end
