class Trip < ApplicationRecord
  belongs_to :route
  belongs_to :bus

  def self.for_date(date)
    return all if date.nil?

    where("start_time BETWEEN ? AND ?", date.beginning_of_day, date.end_of_day)
  end

  def self.for_bus_params(params)
    return all if params.blank?

    joins(:bus)
      .merge(Bus.where(params))
  end
end
