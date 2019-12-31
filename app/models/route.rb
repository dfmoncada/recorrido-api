class Route < ApplicationRecord
  belongs_to :start_location
  belongs_to :end_location
  belongs_to :route_polygon
end
