require 'rails_helper'

RSpec.describe Bet, type: :model do
  fixtures :bets, :games, :teams, :championships

  subject { bets(:sao_w_x_par) }

  ## associations
  it { expect(subject).to belong_to(:user) }
  it { expect(subject).to belong_to(:game) }

  ## validations
  it { expect(subject).to validate_presence_of(:user) }
  it { expect(subject).to validate_presence_of(:game) }
  it { expect(subject).to validate_presence_of(:team_home_goals).on(:update) }
  it { expect(subject).to validate_presence_of(:team_away_goals).on(:update) }
  it { expect(subject).to validate_numericality_of(:team_home_goals).is_greater_than_or_equal_to(0) }
  it { expect(subject).to validate_numericality_of(:team_away_goals).is_greater_than_or_equal_to(0) }

  context 'Played game dont accept bets' do
    it 'in the future' do
      subject.game.played_at = 1.hour.from_now
      subject.team_home_goals = 4
      expect(subject.valid?).to eq true
    end

    it 'in the past' do
      subject.game.played_at = -1.hour.from_now
      subject.team_home_goals = 4
      expect(subject.valid?).to eq false
      expect(subject.errors[:base].count).to eq 1
    end

    it 'dont change goals' do
      subject.game.played_at = -1.hour.from_now
      subject.points = 3
      expect(subject.valid?).to eq true
    end
  end

  ## delegates
  it { expect(subject.played_at).to eq subject.game.played_at }
  it { expect(subject.team_home).to eq subject.game.team_home }
  it { expect(subject.team_away).to eq subject.game.team_away }
  it { expect(subject.bettable?).to eq subject.game.bettable? }

  ## scopes
  describe '.by_championship_in' do
    let(:worldcup) { championships(:worldcup) }
    let(:premier)  { championships(:premier_league) }

    subject { described_class.by_championship_in(worldcup, games(:sao_x_par).played_at) }

    it 'contains only games of championship' do
      expect(subject.pluck(:game_id)).to match_array worldcup.games.pluck(:id)
    end

    it 'does not contains games of others championships' do
      expect(subject.pluck(:game_id)).to_not match_array premier.games.pluck(:id)
    end

    it 'contains only games in interval' do
      expect(subject.pluck(:game_id)).to match_array worldcup.games.pluck(:id)
    end

    it 'does not contains games out of interval' do
      expect(subject.pluck(:game_id)).to_not include games(:par_x_cfc).id
    end
  end

  ## methods
  it { expect(subject.to_s).to eq("#{subject.game.team_home.short_name} vs #{subject.game.team_away.short_name}") }

  context '#goals?' do
    it 'with goals' do
      expect(subject.goals?).to eq true
    end

    it 'without goals' do
      subject.team_home_goals = nil

      expect(subject.goals?).to eq false
    end
  end
end
