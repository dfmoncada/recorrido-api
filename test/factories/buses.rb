FactoryBot.define do
  factory :bus do
    association :tracking_device

    plate { Faker::Vehicle.license_plate }
  end
end
