class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email
      t.integer :weight, null: false
      t.integer :height, null: false
      t.string :goal

      t.timestamps
    end
  end
end
