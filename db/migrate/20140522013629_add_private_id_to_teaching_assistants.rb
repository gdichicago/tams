class AddPrivateIdToTeachingAssistants < ActiveRecord::Migration
  def change
    add_column :teaching_assistants, :private_id, :string
  end
end
