class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.date :date
      t.string :url
      t.string :location
      t.time :time

      t.timestamps
    end
  end
end
