class RenameHoursTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :hours, :hour
  end
end
