FactoryGirl.define do
  factory :game do
    played_at DateTime.new(2014, 6, 20)
    association :team_home, factory: :team
    association :team_away, factory: :away
    team_home_goals 1
    team_away_goals 0
    round
  end
end
