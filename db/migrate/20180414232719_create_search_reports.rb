class CreateSearchReports < ActiveRecord::Migration[5.2]
  def change
    create_table :search_reports do |t|
      t.integer :search_task_id, null: false, index: true
      t.string :keyword, null: false, index: true
      t.jsonb :result_stats
      t.text :html
    end
    add_index :search_reports, :result_stats, using: :gin
    add_index :search_reports, [:search_task_id, :keyword], unique: true
    add_foreign_key :search_reports, :search_tasks
  end
end
