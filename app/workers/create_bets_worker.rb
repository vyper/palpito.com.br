class CreateBetsWorker
  include Sidekiq::Worker

  def perform
    result = Game.select('"games"."id" as "game_id", "members"."user_id" as "user_id"').
                  joins(round: { championship: { groups: :members } }).
                  joins('LEFT JOIN "bets" ON "bets"."user_id" = "members"."user_id" and "bets"."game_id" = "games"."id"').
                  where(bets: { id: nil }).
                  group('"games"."id", "members"."user_id"')

    bets = result.inject([]) do |memo, g|
      memo << { game_id: g.game_id, user_id: g.user_id }
      memo
    end

    Bet.create!(bets)
  end
end