class CreateTalksUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :talks_users, id: false do |t|
      t.references :user, index: true, null: false
      t.references :talk, index: true, null: false
    end
    add_index :talks_users, [:user_id, :talk_id], unique: true
  end
end
