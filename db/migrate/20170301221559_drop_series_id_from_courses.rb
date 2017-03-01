class DropSeriesIdFromCourses < ActiveRecord::Migration[5.0]
  def change
    remove_column :courses, :series_id
  end
end
