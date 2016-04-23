class TodoItem < ActiveRecord::Base
  belongs_to :todo_list, dependent: :delete
  default_scope { order("due_date asc") }
end
