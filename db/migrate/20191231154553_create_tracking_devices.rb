class CreateTrackingDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :tracking_devices do |t|
      t.string :device_serial_number, null: false

      t.timestamps
    end
  end
end
