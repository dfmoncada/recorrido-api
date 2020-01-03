class Tracking < ApplicationRecord
  belongs_to :trip
  after_create :check_finished

  def self.before_time(time)
    where('time < ?', time)
  end

  # refactor to use postgis ST_Dwithin(point, point, distance)
  def self.near_point(point)
    point_string = "POINT(#{point.x} #{point.y})"
    return where("ST_DWithin(coordinates, ST_GeomFromText('#{point_string}', 4326), 100)")

    points = pluck(:id, :coordinates).select do |id, coord|
      Distance.(coord, point) < 0.1
    end

    ids = points.map {|id, coords| id}

    where(id: ids)
  end

  def check_finished
    trip.check_finished(self)
  end

  private

    def backup_code
      distance = Distance.(end_location, coordinates)
      trip.finish if distance < 0.1
    end

    class Distance
      def self.call(point1, point2)
        Geocoder::Calculations
          .distance_between(point_to_array(point1),
                            point_to_array(point2))
      end

      def self.point_to_array(st_point)
        [st_point.x, st_point.y]
      end
    end
end
