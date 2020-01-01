class Route < ApplicationRecord
  belongs_to :start_location, class_name: Location.name
  belongs_to :end_location, class_name: Location.name
  belongs_to :route_polygon
end
