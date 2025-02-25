class AddMuscleGroupToMuscle < ActiveRecord::Migration[7.1]
  def change
    add_reference :muscles, :muscle_group, null: false, foreign_key: true
  end
end
