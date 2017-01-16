class AddCreditHoursToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :credit_hours, :integer
  end
end
