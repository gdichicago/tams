class AddEmailsToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :email, :string
  end
end
