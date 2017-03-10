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
  #
  # def test_will_puts_to_stdout_args_passed_in
  #   assert_output(/I should make a task/) do
  #     TodoCli.new(["new", "i am a task"])
  #   end
  # end

  def test_task_can_be_created
    assert_output(/Created a Task: grocery list/) do
      TodoCli.new(["new", "grocery list"])
    end
    assert_equal Task.first.name, "grocery list"
  end

  def test_task_has_priority
    assert_output(/high priority/) do
      TodoCli.new(["new", "high priority"])
    end
  end

  def test_task_completed
    new_task = TodoCli.new(["new", "high priority"])
    new_task.completed(new_task.task_id)
    #I am aware this doesn't pass, I'm working on it
    assert_in_delta Time.now, new_task.completed_at, 0.1
  end
end
