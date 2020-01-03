FactoryBot.define do
  factory :location do
    name { Faker::Address.city }
    lonlat { 'POINT(-33 -73)' }
  end
end
