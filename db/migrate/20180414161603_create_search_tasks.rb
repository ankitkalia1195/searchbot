class CreateSearchTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :search_tasks do |t|
      t.string :name, null: false
      t.timestamps null: false
    end

    add_index :search_tasks, :name, unique: true
  end
end
