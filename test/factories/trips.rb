FactoryBot.define do
  factory :trip do
    association :bus
    association :route

    start_time { DateTime.new }
    status { 'On Route' }
  end
end
