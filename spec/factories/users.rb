FactoryGirl.define do
  factory :user do
    first_name "Leonardo"
    last_name  "Saraiva"
    nickname   "vyper"
    team
  end

  factory :other_user, class: User do
    first_name "Leo"
    last_name  "SOS"
    nickname   "vpr"
    team
  end
end
