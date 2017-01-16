class AddEndDateToSeries < ActiveRecord::Migration
  def change
    add_column :series, :end_date, :date
  end
end
