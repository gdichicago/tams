class ChangeNumberToFloatForCourses < ActiveRecord::Migration
  def change
    change_column(:courses, :credit_hours, :float)
  end
end
