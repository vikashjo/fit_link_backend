class CreateWorkoutPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_plans do |t|
      t.string :name, null: false
      t.text :description
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end