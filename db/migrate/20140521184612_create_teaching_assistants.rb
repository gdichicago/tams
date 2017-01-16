class CreateTeachingAssistants < ActiveRecord::Migration
  def change
    create_table :teaching_assistants do |t|
      t.string :name
      t.string :email
      t.integer :status_id

      t.timestamps
    end
  end
end
