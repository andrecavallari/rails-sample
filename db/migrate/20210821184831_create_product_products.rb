class CreateProductProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :product_products do |t|
      t.timestamps
      t.string :name, null: false, index: { unique: true }
      t.float :price, null: false
      t.float :final_price, null: false
      t.references :segment, foreign_key: { to_table: :product_segments, on_delete: :restrict }, null: false
    end
  end
end
