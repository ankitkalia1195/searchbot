class CreateSearchTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :search_tasks do |t|
      t.integer :user_id, index: true
      t.string :name, null: false
      t.timestamps null: false
      t.integer :state, default: 0, null: false, index: true
    end

    add_index :search_tasks, [:user_id, :name], unique: true
    add_foreign_key :search_tasks, :users
  end
end
