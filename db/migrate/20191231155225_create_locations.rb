class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.st_point :lonlat, geographic: true

      t.timestamps
    end
  end
end
