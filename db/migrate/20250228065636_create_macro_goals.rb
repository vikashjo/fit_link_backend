class CreateMacroGoals < ActiveRecord::Migration[7.1]
  def change
    create_table :macro_goals do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :calories, null: false
      t.integer :protein, null: false
      t.integer :carbs, null: false
      t.integer :fats, null: false

      t.timestamps
    end
  end
end
