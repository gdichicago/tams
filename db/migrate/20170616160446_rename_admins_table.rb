class RenameAdminsTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :admins, :admin
  end
end
