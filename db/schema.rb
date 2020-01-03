# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_03_023849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "buses", force: :cascade do |t|
    t.string "plate", null: false
    t.bigint "tracking_device_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tracking_device_id"], name: "index_buses_on_tracking_device_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.geography "lonlat", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "route_polygons", force: :cascade do |t|
    t.string "description", null: false
    t.geometry "route_polygon", limit: {:srid=>0, :type=>"st_polygon"}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "routes", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "start_location_id", null: false
    t.bigint "end_location_id", null: false
    t.bigint "route_polygon_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_location_id"], name: "index_routes_on_end_location_id"
    t.index ["route_polygon_id"], name: "index_routes_on_route_polygon_id"
    t.index ["start_location_id"], name: "index_routes_on_start_location_id"
  end

  create_table "tracking_devices", force: :cascade do |t|
    t.string "device_serial_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trackings", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.geometry "coordinates", limit: {:srid=>0, :type=>"st_point"}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "time", null: false
    t.index ["trip_id"], name: "index_trackings_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "bus_id", null: false
    t.bigint "route_id", null: false
    t.datetime "start_time", null: false
    t.string "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "end_time"
    t.index ["bus_id"], name: "index_trips_on_bus_id"
    t.index ["route_id"], name: "index_trips_on_route_id"
  end

  add_foreign_key "buses", "tracking_devices"
  add_foreign_key "routes", "locations", column: "end_location_id"
  add_foreign_key "routes", "locations", column: "start_location_id"
  add_foreign_key "routes", "route_polygons"
  add_foreign_key "trackings", "trips"
  add_foreign_key "trips", "buses"
  add_foreign_key "trips", "routes"
end
