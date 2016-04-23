class AddTodoListIdToUsers < ActiveRecord::Migration
  def change
    add_column :todo_lists, :user_id, :interer
    add_index :todo_lists, :user_id
  end
end
