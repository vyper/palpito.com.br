FactoryGirl.define do
  factory :group do
    name "Group"
    championship
    association :admin, factory: :user
  end
end
