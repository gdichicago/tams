class ChangeTypeBackToInteger < ActiveRecord::Migration
  def change
    change_column(:courses, :credit_hours, :integer)
  end
end
