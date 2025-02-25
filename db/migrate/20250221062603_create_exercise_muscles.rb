class CreateExerciseMuscles < ActiveRecord::Migration[7.1]
  def change
    create_table :exercise_muscles do |t|
      t.references :exercise, null: false, foreign_key: true
      t.references :muscle, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
