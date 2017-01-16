class AddMeetupIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :meetup_id, :string
  end
end
