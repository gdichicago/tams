class RenameTeachingAssistantsTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :teaching_assistants, :teaching_assistant
  end
end
