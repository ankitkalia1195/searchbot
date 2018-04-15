class CreateSearchLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :search_links do |t|
      t.integer :search_report_id, index: true, null: false
      t.string :url, null: false, index: true
      t.integer :link_type, :integer, default: 0, null: false, index: true
    end

    add_foreign_key :search_links, :search_reports
  end
end
