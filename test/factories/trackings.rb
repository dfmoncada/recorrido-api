FactoryBot.define do
  factory :tracking do
    association :trip

    time { DateTime.new }
    coordinates { 'POINT(-72 -33)' }
  end
end
