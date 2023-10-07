class CreatePointLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :point_logs do |t|
      t.integer :value
      t.string :type
      t.string :reason

      t.timestamps
    end
  end
end
