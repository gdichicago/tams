class RemoveHoursFromTeachingAssistants < ActiveRecord::Migration
  def change
    remove_column :teaching_assistants, :hours
  end
end
