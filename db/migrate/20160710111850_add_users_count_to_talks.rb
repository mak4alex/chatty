class AddUsersCountToTalks < ActiveRecord::Migration[5.0]
  def change
    add_column :talks, :users_count, :integer, default: 0
  end
end
