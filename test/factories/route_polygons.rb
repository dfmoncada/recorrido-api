FactoryBot.define do
  factory :route_polygon do
    sequence(:description) {|n| "Route #{n}"}
    route_polygon {'POLYGON((0 0, 1 1, 1 0, 0 0))'}
  end
end
