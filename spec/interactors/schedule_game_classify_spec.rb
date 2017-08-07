require 'rails_helper'

RSpec.describe ScheduleGameClassify, type: :interactor do
  fixtures :games

  subject { ScheduleGameClassify.new game: game }
  let(:game) { games(:sao_x_par) }

  context '#call' do
    it 'have goals' do
      expect(ClassifyGameWorker).to receive(:perform_at).with(game.played_at + 10.minutes, game.id).once
      subject.call
    end

    it 'havent goals' do
      game.team_home_goals = nil
      game.team_away_goals = nil
      expect(ClassifyGameWorker).to_not receive(:perform_at)
      subject.call
    end
  end
end
