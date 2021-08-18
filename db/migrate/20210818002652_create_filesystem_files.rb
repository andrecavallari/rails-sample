class CreateFilesystemFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :filesystem_files do |t|
      t.timestamps
      t.references :directory, index: true, foreign_key: { to_table: :filesystem_directories, on_delete: :cascade }
    end
  end
end
