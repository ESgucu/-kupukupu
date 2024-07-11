class AddDetailsToFlights < ActiveRecord::Migration[7.1]
  def change
    add_column :flights, :travel_date, :date
    add_column :flights, :return_date, :date
    add_column :flights, :currency, :string
  end
end
