class CreateWorkouts < ActiveRecord::Migration[7.1]
  def change
    create_table :workouts do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.text :notes
      t.integer :duration
      
      t.timestamps
    end
  end
end
