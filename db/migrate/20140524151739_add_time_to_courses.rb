class AddTimeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :start_time, :time
    add_column :courses, :end_time, :time
  end
end
