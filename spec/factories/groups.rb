FactoryGirl.define do
  factory :group do
    name "Group"
    association :admin, factory: :user
  end
end
