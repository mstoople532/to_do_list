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
    end
  end

  def new_task
    # p args
    task = Task.new(name: args[1])
    task.save
    puts "Created a Task: #{task.name}"
  end

  def name

  end
end
