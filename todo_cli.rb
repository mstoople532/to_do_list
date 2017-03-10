# Feel free to modify this class but do not rename it.
require_relative "task"

class TodoCli
  attr_reader :args
  def initialize(args)
    @args = args

    # Extract the "subcommand"
    case @args.first
    when "new"
      new_task
    when "name"
      name
    when "priority"
      priority
    when "complete"

    end
  end

  def new_task
    task = Task.new(name: args[1])
    task.save
    puts "Created a Task: #{task.name}"
  end

  def name
  end

  def priority(task_id)
    task = Task.find(task_id)
    task.priority(@args[1])
  end

  def completed(task_id)
    task = Task.find(task_id)
    task.completed_at = Time.now
    task.save
  end
end
