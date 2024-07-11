class CreateFlights < ActiveRecord::Migration[7.1]
  def change
    create_table :flights do |t|
      t.string :destination
      t.integer :price
      t.boolean :selected
      t.integer :ranking

      t.references :membership, foreign_key: true

      t.timestamps
    end
  end
end
