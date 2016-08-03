require 'spec_helper'

RSpec.describe ClassifyBetWorker do
  fixtures :bets, :games, :teams, :users, :championships

  let(:bet)  { bets(:sao_w_x_par) }

  describe '#perform' do
    it 'changes bet points' do
      expect {
        subject.perform(bet.id)
      }.to change { bet.reload.points }.from(nil).to(40)
    end

    it 'invokes calculator with points' do
      expect(BetCalculator).
        to receive(:new).with(
             game_home_goals: bet.game.team_home_goals,
             game_away_goals: bet.game.team_away_goals,
             bet_home_goals:  bet.team_home_goals,
             bet_away_goals:  bet.team_away_goals,
             points:          bet.game.championship.points_base
           ).and_call_original

        subject.perform(bet.id)
    end
  end
end
