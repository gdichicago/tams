class AddFieldsToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :description, :text
    add_column :courses, :num_tas_needed, :integer
  end
end
