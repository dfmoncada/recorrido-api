require 'test_helper'

class TripTest < ActiveSupport::TestCase
  test 'for_date returns all trips in a certain date' do
    now = DateTime.new
    yesterday = 1.days.ago
    tomorrow = 1.days.since

    [now, yesterday, tomorrow].each do |datetime|
      create(:trip, time: datetime)
    end

    results = Trip.for_date(now.to_date)

    assert_equal 1, results.length
  end
end
