require 'spec_helper'

describe Game do
  fixtures :games, :teams, :rounds, :championships

  subject { games(:sao_x_par) }

  ## associations
  it { expect(subject).to belong_to(:team_away).class_name(Team) }
  it { expect(subject).to belong_to(:team_home).class_name(Team) }
  it { expect(subject).to belong_to(:round) }
  it { expect(subject).to have_many(:bets).dependent(:restrict_with_error) }

  ## validations
  it { expect(subject).to validate_presence_of(:played_at) }
  it { expect(subject).to validate_presence_of(:team_away) }
  it { expect(subject).to validate_presence_of(:team_home) }
  it { expect(subject).to validate_presence_of(:round) }
  it { expect(subject).to validate_numericality_of(:team_home_goals).is_greater_than_or_equal_to(0).allow_nil }
  it { expect(subject).to validate_numericality_of(:team_away_goals).is_greater_than_or_equal_to(0).allow_nil }

  context '#played?' do
    subject { games(:sao_x_par) }

    it 'true' do
      expect(subject).to validate_presence_of(:team_home_goals)
      expect(subject).to validate_presence_of(:team_away_goals)
    end

    it 'false' do
      subject.played_at = 1.days.from_now
      expect(subject).to_not validate_presence_of(:team_home_goals)
      expect(subject).to_not validate_presence_of(:team_away_goals)
    end
  end

  context 'only accept game' do
    it 'played with goals' do
      expect(subject.valid?).to eq true
    end

    it 'not played without goals' do
      subject.played_at = 1.day.from_now
      subject.team_home_goals = nil
      subject.team_away_goals = nil

      expect(subject.valid?).to eq true
    end

    it 'not played with goals' do
      subject.played_at = 1.day.from_now

      expect(subject.valid?).to eq false
    end
  end

  context 'only one game by team on round' do
    subject { Game.new round: rounds(:first), played_at: 1.day.from_now }

    it 'already exists team home and away' do
      subject.team_home = teams(:sao)
      subject.team_away = teams(:par)

      expect(subject.valid?).to eq false
      expect(subject.errors[:team_home].count).to eq 1
      expect(subject.errors[:team_away].count).to eq 1
    end

    it 'already exists team home' do
      subject.team_home = teams(:sao)
      subject.team_away = teams(:cfc)

      expect(subject.valid?).to eq false
      expect(subject.errors[:team_home].count).to eq 1
      expect(subject.errors[:team_away].count).to eq 0
    end

    it 'already exists team away' do
      subject.team_home = teams(:cap)
      subject.team_away = teams(:par)

      expect(subject.valid?).to eq false
      expect(subject.errors[:team_home].count).to eq 0
      expect(subject.errors[:team_away].count).to eq 1
    end

    it 'dont exists in the round' do
      subject.team_home = teams(:cap)
      subject.team_away = teams(:cfc)

      expect(subject.valid?).to eq true
      expect(subject.errors[:team_home].count).to eq 0
      expect(subject.errors[:team_away].count).to eq 0
    end

    it 'only changed teams' do
      subject = games(:sao_x_par)
      expect(subject.valid?).to eq true
    end
  end

  ## scopes
  it { expect(Game.not_played.to_sql).to include '"games"."played_at" <' }

  ## delegates
  it { expect(subject.championship).to eq subject.round.championship }

  ## methods
  it { expect(subject.to_s).to eq "#{subject.team_home} vs #{subject.team_away}" }

  context '#bettable?' do
    it 'in the future' do
      subject.played_at = DateTime.now + 1
      expect(subject.bettable?).to eq true
    end

    it 'in the past' do
      subject.played_at = DateTime.now - 1
      expect(subject.bettable?).to eq false
    end
  end

  ## methods
  context '#played?' do
    it 'in the future' do
      subject.played_at = DateTime.now + 1
      expect(subject.played?).to eq false
    end

    it 'in the past' do
      subject.played_at = DateTime.now - 1
      expect(subject.played?).to eq true
    end
  end

  context '#goals?' do
    it 'with goals' do
      expect(subject.goals?).to eq true
    end

    it 'without goals' do
      subject.team_home_goals = nil
      expect(subject.goals?).to eq false
    end
  end

  context '#team_home_winner?' do
    it 'with team home has more goals' do
      expect(subject.team_home_winner?).to eq true
    end

    it 'with team away has more goals' do
      subject.team_away_goals = 2
      expect(subject.team_home_winner?).to eq false
    end

    it 'with team home and away have equal goals' do
      subject.team_away_goals = 1
      expect(subject.team_home_winner?).to eq false
    end
  end

  context '#team_away_winner?' do
    it 'with team home has more goals' do
      expect(subject.team_away_winner?).to eq false
    end

    it 'with team away has more goals' do
      subject.team_away_goals = 2
      expect(subject.team_away_winner?).to eq true
    end

    it 'with team home and away have equal goals' do
      subject.team_away_goals = 1
      expect(subject.team_away_winner?).to eq false
    end
  end

  context '#tied?' do
    it 'with team home has more goals' do
      expect(subject.tied?).to eq false
    end

    it 'with team away has more goals' do
      subject.team_away_goals = 2
      expect(subject.tied?).to eq false
    end

    it 'with team home and away have equal goals' do
      subject.team_away_goals = 1
      expect(subject.tied?).to eq true
    end
  end
end
