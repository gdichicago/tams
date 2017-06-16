class DropEmailSentColumnFromHourTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :hour, :email_sent
  end
end
