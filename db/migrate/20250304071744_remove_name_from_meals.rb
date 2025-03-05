class RemoveNameFromMeals < ActiveRecord::Migration[7.1]
  def change
    remove_column :meals, :name, :string
  end
end
