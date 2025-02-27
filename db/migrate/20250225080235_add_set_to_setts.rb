class AddSetToSetts < ActiveRecord::Migration[7.1]
  def change
    add_column :setts, :set, :integer
    add_column :setts, :hit, :boolean
  end
end
