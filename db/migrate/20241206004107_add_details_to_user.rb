class AddDetailsToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string, limit: 30
    add_column :users, :role, :string, limit: 30, default: "user"
  end
end
