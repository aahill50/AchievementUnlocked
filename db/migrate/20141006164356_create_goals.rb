class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :description
      t.integer :user_id, null: false
      t.boolean :private_goal, default: true, null: false
      t.boolean :completed, default: false, null: false

      t.timestamps
    end

    add_index :goals, :user_id
    add_index :goals, [:user_id, :title]
  end
end
