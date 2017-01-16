class AddPrettyDateAndTimeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :pretty_time, :string
    add_column :courses, :pretty_date, :string
  end
end
