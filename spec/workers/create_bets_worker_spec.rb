require 'rails_helper'

RSpec.describe CreateBetsWorker, type: :worker do
  fixtures :games, :users, :members, :teams, :bets, :championships

  describe '#perform' do
    context 'user without bet in game' do
      let(:team_home)    { teams(:sao) }
      let(:team_away)    { teams(:cfc) }
      let(:championship) { championships(:worldcup) }
      let!(:new_game)    { Game.create(team_home: team_home, team_away: team_away, championship: championship, played_at: Date.tomorrow) }

      it 'creates bet using random goals' do
        subject.perform

        last_bet = Bet.last
        expect(last_bet.team_home_goals.in?([1,2,3,4])).to be_truthy
        expect(last_bet.team_away_goals.in?([1,2,3,4])).to be_truthy
      end

      it 'creates bet for games without bet' do
        expect {
          subject.perform
        }.to change(Bet, :count).by(1)
      end
    end

    it 'does not create bet to user with bet in all games' do
      expect {
        subject.perform
      }.to_not change(Bet, :count)
    end
  end
end
