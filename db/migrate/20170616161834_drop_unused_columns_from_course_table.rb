class DropUnusedColumnsFromCourseTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :course, :description
    remove_column :course, :meetup_id
    remove_column :course, :pretty_time
    remove_column :course, :pretty_date
  end
end
