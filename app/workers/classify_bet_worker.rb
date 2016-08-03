class ClassifyBetWorker
  include Sidekiq::Worker

  def perform(bet_id)
    bet = Bet.find(bet_id)

    calculator = BetCalculator.new({
      game_home_goals: bet.game.team_home_goals,
      game_away_goals: bet.game.team_away_goals,
      bet_home_goals:  bet.team_home_goals,
      bet_away_goals:  bet.team_away_goals,
      points:          bet.game.championship.points_base
    })

    bet.update points: calculator.calculate
  end
end
