require 'active_record'
class CreateTasksTableMigration < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :priority
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :completed_at
    end
  end
end
