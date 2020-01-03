require 'test_helper'

class TrackingTest < ActiveSupport::TestCase
  # basically check if the 
  test "after_create, if on end_location, finish trip" do
    point = 'POINT(-73 -33)'
    other_point = 'POINT(-72 -31)'
    end_location = create(:location,
                          lonlat: point)
    route = create(:route,
                   end_location: end_location)
    trip = create(:trip,
                  status:'in_progress',
                  route: route)
    tracking = create(:tracking,
                      trip: trip,
                      coordinates: other_point)
    assert_equal 'in_progress', trip.reload.status

    tracking = create(:tracking,
                      trip: trip,
                      coordinates: point)
    assert_equal 'finished', trip.reload.status
  end

  test "tracking updates trip status if haven't moved 100 meters" do
    start_time = DateTime.now - 20.minutes
    trip = create(:trip, start_time: start_time)
    tracking1 = create(:tracking,
                      trip: trip,
                      time: start_time,
                      coordinates: 'POINT(0 0)')

    assert_equal 'in_progress', trip.reload.status

    tracking2 = create(:tracking,
                      trip: trip,
                      time: DateTime.now,
                      coordinates: tracking1.coordinates)

    assert_equal 'incomplete', trip.reload.status
  end

  test "tracking doesn't change trip status if moving" do
    start_time = DateTime.now - 20.minutes
    trip = create(:trip, start_time: start_time)
    tracking1 = create(:tracking,
                      trip: trip,
                      time: start_time,
                      coordinates: 'POINT(1 1)')

    assert_equal 'in_progress', trip.reload.status

    tracking2 = create(:tracking,
                      trip: trip,
                      time: DateTime.now,
                      coordinates: 'POINT(0 0)')

    assert_equal 'in_progress', trip.reload.status
  end

  test "tracking change trip status to complete if gets to end location" do
    start_time = DateTime.now - 20.minutes
    trip = create(:trip, start_time: start_time)
    tracking1 = create(:tracking,
                      trip: trip,
                      time: start_time,
                      coordinates: 'POINT(1 1)')

    assert_equal 'in_progress', trip.reload.status

    tracking2 = create(:tracking,
                      trip: trip,
                      time: DateTime.now,
                      coordinates: trip.route.end_location.lonlat)

    assert_equal 'finished', trip.reload.status
  end

  test "previous methods have a distance of margin" do
    start_time = DateTime.now - 20.minutes
    trip = create(:trip, start_time: start_time)
    tracking1 = create(:tracking,
                      trip: trip,
                      time: start_time,
                      coordinates: 'POINT(1 1)')

    assert_equal 'in_progress', trip.reload.status

    coordinates = trip.route.end_location.lonlat
    tracking2 = create(:tracking,
                      trip: trip,
                      time: DateTime.now,
                      coordinates: 'POINT(1 1.000002)')

    assert_equal 'incomplete', trip.reload.status
  end
end
