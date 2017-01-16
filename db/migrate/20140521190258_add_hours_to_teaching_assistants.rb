class AddHoursToTeachingAssistants < ActiveRecord::Migration
  def change
    add_column :teaching_assistants, :hours, :integer
  end
end
