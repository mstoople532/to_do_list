require "sqlite3"
require "active_record"
require "minitest/autorun"
require "minitest/pride"
require "minitest/focus"
require "pry"
require_relative "todo_cli"
require_relative "create_tasks_table_migration"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "test.db"
)

class TodoCliTest < Minitest::Test
  def setup
    CreateTasksTableMigration.migrate(:up)
  end

  def teardown
    CreateTasksTableMigration.migrate(:down)
  end

  def test_task_can_be_created
    assert_output(/Created a Task: grocery list/) do
      TodoCli.new(["new", "grocery list"])
    end
    assert_equal Task.first.name, "grocery list"
  end

  def test_task_has_priority
    task = Task.create(name: "get groceries", priority: "medium")
    assert_output(/Task Priority: medium/) do
      TodoCli.new(["priority", task.id])
    end
  end

  def test_task_completed
    task = Task.create(name: "eating", priority: "Urgent")
    assert_output(/Eating is completed/) do
      TodoCli.new(["complete", task.id])
    end
    task.reload
    assert_in_delta Time.now, task.completed_at, 0.1
  end

  def test_list_all_tasks
    Task.create(name: "sleeping", priority: "low")
    Task.create(name: "homework", priority: "high")
    TodoCli.new(["list tasks"])
    binding.pry
  end
end
