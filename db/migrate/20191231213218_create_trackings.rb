class CreateTrackings < ActiveRecord::Migration[6.0]
  def change
    create_table :trackings do |t|
      t.references :trip, null: false, foreign_key: true
      t.st_point :coordinates, null: false

      t.timestamps
    end
  end
end
