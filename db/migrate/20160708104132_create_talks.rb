class CreateTalks < ActiveRecord::Migration[5.0]
  def change
    create_table :talks do |t|
      t.string :title, default: "", null: false

      t.timestamps
    end
  end
end
