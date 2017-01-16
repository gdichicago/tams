class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.integer :course_id
      t.integer :teaching_assistant_id
      t.integer :num

      t.timestamps
    end
  end
end
