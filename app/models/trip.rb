class Trip < ApplicationRecord
  belongs_to :route
  belongs_to :bus
  has_many :trackings

  def self.for_date(date)
    return all if date.nil?

    where("start_time BETWEEN ? AND ?", date.beginning_of_day, date.end_of_day)
  end

  def self.for_bus_params(params)
    return all if params.blank?

    joins(:bus)
      .merge(Bus.where(params))
  end

  def check_finished(last_tracking)
    return incomplete(last_tracking.time) if stopped?(last_tracking)

    finish(last_tracking.time) if finished?
  end

  def stopped?(last_tracking)
    trackings.before_time(last_tracking.time - 15.minutes)
             .near_point(last_tracking.coordinates)
             .any?
  end

  def finished?
    trackings.near_point(route.end_location.lonlat)
             .any?
  end

  def finish(time)
    update(status: 'finished',
           end_time: time)
  end

  def incomplete(time)
    update(status: 'incomplete',
           end_time: time)
  end
end
