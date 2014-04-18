FactoryGirl.define do
  factory :bet do
    association :user, factory: :user, strategy: :build
    game
    team_home_goals 1
    team_away_goals 0
  end
end
