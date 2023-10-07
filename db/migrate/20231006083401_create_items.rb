class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.integer :price
      t.string :name

      t.timestamps
    end
  end
end
