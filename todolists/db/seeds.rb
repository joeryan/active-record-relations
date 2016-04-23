# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# clear database tables
ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  ActiveRecord::Base.connection.execute("DELETE FROM #{table}") unless table == "schema_migrations"
end

#populate tables
user_list = [
  ["Carly", "Fiorina", "1954", "female"],
  ["Donald", "Trump", "1946", "male"],
  ["Ben", "Carson", "1951", "male"],
  ["Hillary", "Clinton", "1947", "female"]
]

todos = ["shopping trip", "speech", "argument", "party", "dinner"]
status = ["boring", "super", "fun", "amazing", "stupid"]
due_date = Date.today + 1.year

user_list.each do |fname, lname, byear, gender|
  todolist_name = "#{fname} #{lname}'s' Amazing ToDo List"

  user = User.create(username: lname, password_digest: "#{lname}#{byear}")
  Profile.create(gender: gender, birth_year: byear, first_name: fname,
                  last_name: lname, user_id: user.id)
  tlist = TodoList.create(user_id: user.id,
                          list_name: todolist_name,
                          list_due_date: due_date)
end

users = Profile.all
users.each do |user|
  todos.each do |todo|
    pal = users.sample.first_name
    TodoItem.create(due_date: due_date,
                    title: "#{todo} with #{pal}",
                    description: "Another #{status.sample} #{todo} with #{pal}",
                    completed: false,
                    :todo_list_id => TodoList.find_by(user_id: user.user_id).id
    )
  end
end
