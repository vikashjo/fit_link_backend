class CreateMealTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :meal_types do |t|
      t.string :name
      t.text :description
      t.datetime :default_time
      t.boolean :main_meal
      t.jsonb   :recommended_macros, default: {}

      t.timestamps
    end
  end
end
