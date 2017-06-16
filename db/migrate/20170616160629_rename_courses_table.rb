class RenameCoursesTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :courses, :course
  end
end
