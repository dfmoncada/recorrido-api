class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|
      t.string :name, null: false
      t.references :start_location, null: false, foreign_key: {to_table: :locations}
      t.references :end_location, null: false, foreign_key: {to_table: :locations}
      t.references :route_polygon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
