class AddEmailFlagToHours < ActiveRecord::Migration
  def change
    add_column :hours, :email_sent, :boolean, default: false
    # run rake data:hours_email_sent AFTER this migration
  end
end
