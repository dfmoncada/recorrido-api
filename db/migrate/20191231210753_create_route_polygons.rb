class CreateRoutePolygons < ActiveRecord::Migration[6.0]
  def change
    create_table :route_polygons do |t|
      t.string :description, null: false
      t.st_polygon :route_polygon, null: false

      t.timestamps
    end
  end
end
