class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  has_many :todo_lists, dependent: :destroy
  has_many :todo_items, through: :todo_lists, source: :todo_items
  validates_presence_of :username

  def get_completed_count
    # lists = []
    # TodoList.where(user_id: id).each {|l| lists << l.id}
    TodoItem.where(todo_list_id: TodoList.select(:id).where(user_id: id),
      completed: true).count
  end
end
