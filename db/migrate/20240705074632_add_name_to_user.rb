class AddNameToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string

    create_table :memberships do |t|
      t.references :groups, foreign_key: true
      t.references :users, foreign_key: true
      t.timestamps
    end

  end
end
