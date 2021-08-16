class CreateFilesystemDirectories < ActiveRecord::Migration[6.1]
  def change
    create_table :filesystem_directories do |t|
      t.timestamps
      t.string :name, null: false
      t.bigint :parent_id
    end

    add_foreign_key :filesystem_directories, :filesystem_directories, column: :parent_id, on_delete: :cascade
    add_index :filesystem_directories, %i[name parent_id], unique: true
  end
end
