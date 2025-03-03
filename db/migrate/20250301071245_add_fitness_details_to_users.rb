class AddFitnessDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :age, :integer, null: false, default: 18
    add_column :users, :gender, :string
    add_column :users, :activity_level, :string
  end
end
