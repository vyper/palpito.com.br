require 'spec_helper'

describe Game do
  ## associations
  it { expect(subject).to belong_to(:team_away).class_name(Team) }
  it { expect(subject).to belong_to(:team_home).class_name(Team) }
  it { expect(subject).to belong_to(:round) }

  ## validations
  it { expect(subject).to validate_presence_of(:played_at) }
  it { expect(subject).to validate_presence_of(:team_away) }
  it { expect(subject).to validate_presence_of(:team_home) }
  it { expect(subject).to validate_presence_of(:round) }
  it { expect(subject).to ensure_length_of(:team_home_goals).is_at_least(0) }
  it { expect(subject).to ensure_length_of(:team_away_goals).is_at_least(0) }

  ## methods
  context '#bettable?' do
    it 'in the future' do
      subject = build(:game, played_at: DateTime.now + 1)
      expect(subject.bettable?).to eq true
    end

    it 'in the past' do
      subject = build(:game, played_at: DateTime.now - 1)
      expect(subject.bettable?).to eq false
    end
  end

  ## methods
  context '#played?' do
    it 'in the future' do
      subject = build(:game, played_at: DateTime.now + 1)
      expect(subject.played?).to eq false
    end

    it 'in the past' do
      subject = build(:game, played_at: DateTime.now - 1)
      expect(subject.played?).to eq true
    end
  end

  context '#goals?' do
    it 'with goals' do
      expect(build(:game).goals?).to eq true
    end

    it 'without goals' do
      expect(build(:game, team_home_goals: nil).goals?).to eq false
    end
  end

  context '#team_home_winner?' do
    it 'with team home has more goals' do
      expect(build(:game).team_home_winner?).to eq true
    end

    it 'with team away has more goals' do
      expect(build(:game, team_away_goals: 2).team_home_winner?).to eq false
    end

    it 'with team home and away have equal goals' do
      expect(build(:game, team_away_goals: 1).team_home_winner?).to eq false
    end
  end

  context '#team_away_winner?' do
    it 'with team home has more goals' do
      expect(build(:game).team_away_winner?).to eq false
    end

    it 'with team away has more goals' do
      expect(build(:game, team_away_goals: 2).team_away_winner?).to eq true
    end

    it 'with team home and away have equal goals' do
      expect(build(:game, team_away_goals: 1).team_away_winner?).to eq false
    end
  end

  context '#tied?' do
    it 'with team home has more goals' do
      expect(build(:game).tied?).to eq false
    end

    it 'with team away has more goals' do
      expect(build(:game, team_away_goals: 2).tied?).to eq false
    end

    it 'with team home and away have equal goals' do
      expect(build(:game, team_away_goals: 1).tied?).to eq true
    end
  end
end
