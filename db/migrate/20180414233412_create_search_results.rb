class CreateSearchResults < ActiveRecord::Migration[5.2]
  def change
    create_table :search_results do |t|
      t.integer :search_report_id, index: true, null: false
      t.string :url, null: false, index: true
      t.integer :result_type, :integer, default: 0, null: false, index: true
      t.timestamps null: false
    end

    add_foreign_key :search_results, :search_reports
  end
end
