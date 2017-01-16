class AddEmailSentFlagToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :email_sent, :boolean, default: false
  end
end
