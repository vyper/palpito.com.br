class ClassifyGameWorker
  include Sidekiq::Worker

  def perform(game_id)
    game = Game.find(game_id)

    if game.goals?
      game.bets.each do |bet|
        ClassifyBetWorker.perform_async(bet.id)
      end
    end
  end
end
