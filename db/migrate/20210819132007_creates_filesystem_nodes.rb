class CreatesFilesystemNodes < ActiveRecord::Migration[6.1]
  def change
    create_table :filesystem_nodes do |t|
      t.timestamps
      t.string :type, null: false
      t.references :parent, index: true, foreign_key: { to_table: :filesystem_nodes, on_delete: :cascade, column: :parent_id }
      t.string :name, index: true
    end
  end
end
