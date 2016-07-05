class CreateBetsWorker
  include Sidekiq::Worker

  def perform
    rows = Game.select('"games"."id" as "game_id", "members"."user_id" as "user_id"').
                  joins(championship: { groups: :members }).
                  joins('LEFT JOIN "bets" ON "bets"."user_id" = "members"."user_id" and "bets"."game_id" = "games"."id"').
                  where(bets: { id: nil }).
                  group('"games"."id", "members"."user_id"')

    rows.each do |row|
      Bet.create(
        game_id: row.game_id,
        user_id: row.user_id,
        team_home_goals: sample_goal,
        team_away_goals: sample_goal
      )
    end
  end

  private

  def sample_goal
    [1, 2, 3, 4].sample
  end
end
