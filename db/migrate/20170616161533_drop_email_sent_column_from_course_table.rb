class DropEmailSentColumnFromCourseTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :course, :email_sent
  end
end
