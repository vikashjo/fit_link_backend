class AddSecondaryMusclesToExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :exercises, :secondary_muscles, :string, array: true, default: []
  end
end
