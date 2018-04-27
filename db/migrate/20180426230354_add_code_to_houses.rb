class AddCodeToHouses < ActiveRecord::Migration[5.1]
  def change
    add_column :houses, :code, :string
  end
end
