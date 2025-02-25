class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :muscle_group
      
      t.timestamps
    end
  end
end
