FactoryBot.define do
  factory :trip do
    association :bus
    association :route

    time { DateTime.new }
    status { 'On Route' }
  end
end
