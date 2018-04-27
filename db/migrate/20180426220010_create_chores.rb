class CreateChores < ActiveRecord::Migration[5.1]
  def change
    create_table :chores do |t|
      t.references :house, foreign_key: true
      t.text :description
      t.boolean :completed

      t.timestamps
    end
  end
end
