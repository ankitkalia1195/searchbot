class CreateSearchReports < ActiveRecord::Migration[5.2]
  def change
    create_table :search_reports do |t|
      t.integer :search_task_id, null: false, index: true
      t.string :keyword, null: false, index: true
      t.jsonb :link_counters
      t.string :time_taken
      t.integer :total_result_count
      t.text :html
    end
    add_index :search_reports, :link_counters, using: :gin
    add_foreign_key :search_reports, :search_tasks

  end
end
