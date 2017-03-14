# Feel free to modify this class but do not rename it.
require_relative "task"

class TodoCli
  attr_reader :args
  def initialize(args)
    @args = args
    case @args.first
    when "new"
      new_task
    when "list tasks"
      list_all_tasks
    when "priority"
      priority(@args[1])
    when "complete"
      completed(@args[1])
    else
      puts "Please enter valid request"
    end
  end

  def new_task
    task = Task.create(name: args[1], priority: args[2])
    puts "Created a Task: #{task.name}"
  end

  def priority(task_id)
    task = Task.find(task_id)
    task.priority
    puts "Task Priority: #{task.priority}"
  end

  def completed(task_id)
    task = Task.find(task_id)
    task.completed_at = Time.now
    task.save
    puts "#{task.name.capitalize} is completed"
  end

  def list_all_tasks
    Task.all
  end
end
