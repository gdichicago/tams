class RenameStatusesTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :statuses, :status
  end
end
