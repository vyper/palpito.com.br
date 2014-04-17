FactoryGirl.define do
  factory :championship do
    name        "Copa do Mundo"
    started_at  DateTime.new(2014, 6, 12)
    finished_at DateTime.new(2014, 7, 15)
  end
end
