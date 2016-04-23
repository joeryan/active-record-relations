class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  has_many :todo_lists, dependent: :destroy
  has_many :todo_items, through: :todo_lists, source: :todo_items
  validates_presence_of :username

  def get_completed_count
    completed_count = 0
    user_todo_lists = TodoList.where(user_id: id)
    user_todo_lists.each do |user_list|
      completed_count += TodoItem.find_by(todo_list_id: user_list.id, completed: true)
    end
    return completed_count
  end
end
