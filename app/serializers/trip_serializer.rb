class TripSerializer < ActiveModel::Serializer
  belongs_to :bus

  attributes :id, :status, :start_time, :end_time
end
