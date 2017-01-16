class RemoveTimeFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :time
  end
end
