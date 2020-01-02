FactoryBot.define do
  factory :tracking_device do
    device_serial_number { SecureRandom.uuid }
  end
end
