class CreateBuses < ActiveRecord::Migration[6.0]
  def change
    create_table :buses do |t|
      t.string :plate, null: false
      t.references :tracking_device, null: false, foreign_key: true

      t.timestamps
    end
  end
end
