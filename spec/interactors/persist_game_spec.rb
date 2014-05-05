require 'spec_helper'

describe PersistGame do
  fixtures :games

  let(:game) { games(:sao_x_par) }
  let(:params) { { id: game.id, team_home_goals: 3, team_away_goals: 0 } }

  context '.perform' do
    it 'with valid game' do
      subject = PersistGame.perform game: game, params: params
      expect(subject.game.valid?).to eq true
    end

    it 'with invalid game' do
      subject = PersistGame.perform game: game, params: params.merge(team_home_id: nil)
      expect(subject.game.valid?).to eq false
    end
  end
end
