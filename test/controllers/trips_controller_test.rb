require 'test_helper'

class TripsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get trips_index_url
    assert_response 200
  end

  test "index can filter by date" do
    now = DateTime.new
    yesterday = 1.days.ago
    tomorrow = 1.days.since
    [now, yesterday, tomorrow].each do |datetime|
      create(:trip, start_time: datetime)
    end

    get trips_index_url, params: {date: now.to_date}

    result = JSON.parse(@response.body)
    assert_equal 1, result.count
  end

  test "index can filter by route_id" do
    routes = create_list :route, 2
    trips = routes.map {|route| create(:trip, route: route)}

    get trips_index_url, params: {route_id: routes.first.id}

    result = JSON.parse(@response.body)
    assert_equal 1, result.count
  end

  test "index can filter by license plate" do
    buses = ['AAAA-11', 'BBBB-1'].map {|plate| create(:bus, plate: plate)}
    trips = buses.map {|bus| create(:trip, bus: bus)}

    get trips_index_url, params: {plate: buses[0].plate}

    result = JSON.parse(@response.body)
    assert_equal 1, result.count
  end
end
