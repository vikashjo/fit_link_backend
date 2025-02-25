class CreateWorkoutPlanExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_plan_exercises do |t|
      t.references :workout_plan, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.integer :recommended_sets
      t.integer :recommended_reps
      t.text :notes
      
      t.timestamps
    end
  end
end 