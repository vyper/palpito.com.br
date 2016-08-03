require 'spec_helper'

RSpec.describe BetCalculator do
  let(:default_params) { { game_home_goals: 1, game_away_goals: 1, bet_home_goals: 1, bet_away_goals: 1 } }
  let(:params)         { default_params }

  subject { BetCalculator.new(params) }

  describe '#points' do
    it 'without points uses default value' do
      expect(subject.points).to eq BetCalculator::POINTS
    end

    context 'with points' do
      let(:params) { default_params.merge(points: 50) }

      it 'uses received points' do
        expect(subject.points).to eq 50
      end
    end
  end

  context '#goals?' do
    it('with goals') { expect(subject.goals?).to eq true }

    context 'without goals' do
      it 'without game_home_goals' do
        subject.game_home_goals = nil
        expect(subject.goals?).to eq false
      end

      it 'without game_away_goals' do
        subject.game_away_goals = nil
        expect(subject.goals?).to eq false
      end

      it 'without bet_home_goals' do
        subject.bet_home_goals = nil
        expect(subject.goals?).to eq false
      end

      it 'without bet_away_goals' do
        subject.bet_away_goals = nil
        expect(subject.goals?).to eq false
      end
    end
  end

  context '#game_home_winner?' do
    it 'home is greater' do
      subject.game_home_goals = 3
      expect(subject.game_home_winner?).to eq true
    end

    it 'away is greater' do
      subject.game_away_goals = 3
      expect(subject.game_home_winner?).to eq false
    end

    it 'tied' do
      expect(subject.game_home_winner?).to eq false
    end
  end

  context '#game_away_winner?' do
    it 'home is greater' do
      subject.game_home_goals = 3
      expect(subject.game_away_winner?).to eq false
    end

    it 'away is greater' do
      subject.game_away_goals = 3
      expect(subject.game_away_winner?).to eq true
    end

    it 'tied' do
      expect(subject.game_away_winner?).to eq false
    end
  end

  context '#game_tied?' do
    it 'home is greater' do
      subject.game_home_goals = 3
      expect(subject.game_tied?).to eq false
    end

    it 'away is greater' do
      subject.game_away_goals = 3
      expect(subject.game_tied?).to eq false
    end

    it 'tied' do
      expect(subject.game_tied?).to eq true
    end
  end

  context '#bet_home_winner?' do
    it 'home is greater' do
      subject.bet_home_goals = 3
      expect(subject.bet_home_winner?).to eq true
    end

    it 'away is greater' do
      subject.bet_away_goals = 3
      expect(subject.bet_home_winner?).to eq false
    end

    it 'tied' do
      expect(subject.bet_home_winner?).to eq false
    end
  end

  context '#bet_away_winner?' do
    it 'home is greater' do
      subject.bet_home_goals = 3
      expect(subject.bet_away_winner?).to eq false
    end

    it 'away is greater' do
      subject.bet_away_goals = 3
      expect(subject.bet_away_winner?).to eq true
    end

    it 'tied' do
      expect(subject.bet_away_winner?).to eq false
    end
  end

  context '#bet_tied?' do
    it 'home is greater' do
      subject.bet_home_goals = 3
      expect(subject.bet_tied?).to eq false
    end

    it 'away is greater' do
      subject.bet_away_goals = 3
      expect(subject.bet_tied?).to eq false
    end

    it 'tied' do
      expect(subject.bet_tied?).to eq true
    end
  end

  context '#bet_is_correct?' do
    it 'are equal' do
      expect(subject.bet_is_correct?).to be true
    end

    it 'arent equal' do
      subject.game_home_goals = 4
      subject.bet_away_goals = 7
      expect(subject.bet_is_correct?).to be false
    end
  end

  it '#calculator' do
    [
      [ 2,  1,  2,  1, 10,  40],
      [ 1,  2,  1,  2, 10,  40],
      [ 2,  2,  2,  2, 10,  40],
      [ 9,  9,  9,  9, 10,  40],
      [ 1,  3,  1,  2, 10,  29],
      [ 1,  2,  1,  3, 10,  29],
      [ 1,  4,  1,  2, 10,  28],
      [ 1,  2,  1,  4, 10,  28],
      [ 0,  0,  5,  5, 10,  20],
      [ 6,  6,  1,  1, 10,  20],
      [ 0,  0, 21, 28, 50,   0],
      [ 1,  2, 21, 28, 50, 104],
      [35, 40, 21, 28, 50, 124],
      [ 0,  0,  0,  0, 50, 200],
    ].each do |items|
      subject.game_home_goals = items[0]
      subject.game_away_goals = items[1]
      subject.bet_home_goals  = items[2]
      subject.bet_away_goals  = items[3]
      subject.points          = items[4]

      expect(subject.calculate).to eq items[5]
    end
  end
end
