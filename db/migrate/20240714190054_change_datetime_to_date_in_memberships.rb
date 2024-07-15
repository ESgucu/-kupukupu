class ChangeDatetimeToDateInMemberships < ActiveRecord::Migration[7.1]
  def change
    change_column :memberships, :travel_date, :date
    change_column :memberships, :return_date, :date
  end
end
