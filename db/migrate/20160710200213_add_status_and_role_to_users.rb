class AddStatusAndRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :status, :string, default: ""
    add_column :users, :role, :string, default: ""
  end
end
