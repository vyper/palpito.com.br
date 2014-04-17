FactoryGirl.define do
  factory :team do
    name       "São Paulo"
    short_name "SAO"
    image      File.new(File.join(Rails.root, 'spec', 'support', 'test.png'))
  end
end
