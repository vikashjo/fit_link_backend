class CreateMuscles < ActiveRecord::Migration[7.1]
  def change
    create_table :muscles do |t|
      t.string :name

      t.timestamps
    end
  end
end
