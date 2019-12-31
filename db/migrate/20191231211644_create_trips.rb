class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.references :bus, null: false, foreign_key: true
      t.references :route, null: false, foreign_key: true
      t.datetime :time, null: false, foreign_key: true
      t.string :status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
