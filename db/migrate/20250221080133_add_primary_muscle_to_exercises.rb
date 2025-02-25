class AddPrimaryMuscleToExercises < ActiveRecord::Migration[7.1]
  def change
    add_reference :exercises, :primary_muscle, foreign_key: { to_table: :muscles }
  end
end
