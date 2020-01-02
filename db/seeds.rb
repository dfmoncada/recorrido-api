BUS_NUMBER = 5
TRIPS_PER_BUS = 2
GEO_FILE = File.read('db/santiago-peor-es-nada.geojson')
GEO_POLYGON = JSON.parse(GEO_FILE)['features'][0]['geometry']['coordinates'][0]

Tracking.delete_all
Trip.delete_all
Route.delete_all
RoutePolygon.delete_all
Location.delete_all
Bus.delete_all
TrackingDevice.delete_all

tracking_devices = BUS_NUMBER.times.collect do
  TrackingDevice.create device_serial_number: SecureRandom.uuid
end

buses = tracking_devices.each.collect do |tracking_device|
  Bus.create tracking_device: tracking_device,
             plate: Faker::Vehicle.license_plate
end

locations = [
  ['Santiago', -33.45382270754665, -70.69075584411621],
  ['Peor Es Nada', -34.791074253715365, -71.04652404785156]
].map do |name, long, lat|
  Location.create name: name,
                  lonlat: "POINT(#{long} #{lat})"
end

polygon_coordinates_string = GEO_POLYGON.map{|lon, lat| "#{lon} #{lat}"}
                                        .join(', ')
route_polygon = RoutePolygon.create description: "Santiago - Peor es Nada",
                                    route_polygon: "POLYGON((#{polygon_coordinates_string}))"

routes = [
  ['Santiago => Peor es Nada', locations.first, locations.second, route_polygon],
  ['Peor es Nada => Santiago', locations.second, locations.first, route_polygon],
].map do |name, start_location, end_location, route_polygon|
  Route.create name: name,
               start_location: start_location,
               end_location: end_location,
               route_polygon: route_polygon
end

trips = 100.times.with_index.collect do |idx|
  route = routes[idx % 2]
  bus = buses[idx % 5]
  datetime = ((idx + 1) * 144).minutes.ago

  Trip.create(route: route,
              bus: bus,
              time: datetime,
              status: 'in progress')
end.flatten
