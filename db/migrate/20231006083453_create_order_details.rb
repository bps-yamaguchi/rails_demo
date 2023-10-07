class CreateOrderDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :order_details do |t|
      t.belongs_to :order, null: false, foreign_key: true
      t.string :item
      t.string :belongs_to
      t.integer :amount

      t.timestamps
    end
  end
end
