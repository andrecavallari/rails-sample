class CreateStoreSegments < ActiveRecord::Migration[6.1]
  def change
    create_table :store_segments do |t|
      t.timestamps
      t.string :name, null: false
      t.string :operation, null: false
    end
  end
end
