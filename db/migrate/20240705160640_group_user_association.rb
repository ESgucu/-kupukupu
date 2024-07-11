class GroupUserAssociation < ActiveRecord::Migration[7.1]
  def change
    add_column :groups, :inv_code, :string
    add_column :users, :group_id, :integer
    add_foreign_key :users, :groups
    add_index :users, :group_id
    add_column :groups, :user_id, :integer
    add_foreign_key :groups, :users
    add_index :groups, :user_id
  end
end
