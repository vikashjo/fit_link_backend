class CreateSetts < ActiveRecord::Migration[7.1]
  def change
    create_table :setts do |t|
      t.references :exercise, null: false, foreign_key: true
      t.references :workout, null: false, foreign_key: true
      t.integer :reps
      t.integer :weight

      t.timestamps
    end
  end
end
