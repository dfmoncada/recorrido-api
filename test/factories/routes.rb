FactoryBot.define do
  factory :route do
    association :start_location, factory: :location
    association :end_location, factory: :location
    association :route_polygon
  end
end
