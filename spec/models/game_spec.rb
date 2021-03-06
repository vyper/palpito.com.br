require 'rails_helper'

RSpec.describe Game do
  fixtures :games, :teams, :championships

  subject { games(:sao_x_par) }

  ## associations
  it { is_expected.to belong_to(:team_away).class_name(Team) }
  it { is_expected.to belong_to(:team_home).class_name(Team) }
  it { is_expected.to belong_to(:championship) }
  it { is_expected.to have_many(:bets).dependent(:restrict_with_error) }

  ## validations
  it { is_expected.to validate_presence_of(:played_at) }
  it { is_expected.to validate_presence_of(:team_away) }
  it { is_expected.to validate_presence_of(:team_home) }
  it { is_expected.to validate_numericality_of(:team_home_goals).is_greater_than_or_equal_to(0).allow_nil }
  it { is_expected.to validate_numericality_of(:team_away_goals).is_greater_than_or_equal_to(0).allow_nil }

  context '#played?' do
    subject { games(:sao_x_par) }

    it 'true' do
      is_expected.to validate_presence_of(:team_home_goals)
      is_expected.to validate_presence_of(:team_away_goals)
    end

    it 'false' do
      subject.played_at = 1.days.from_now
      is_expected.to_not validate_presence_of(:team_home_goals)
      is_expected.to_not validate_presence_of(:team_away_goals)
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

  ## scopes
  it { expect(Game.played.to_sql).to include '"games"."played_at" <' }
  it '.of_day' do
    starts_at = Date.today.beginning_of_day.utc.strftime('%F %H:%M:%S')
    ends_at = Date.today.end_of_day.utc.strftime('%F %H:%M:%S.%6N')

    expect(Game.of_day.to_sql).to include %{"games"."played_at" BETWEEN '#{starts_at}' AND '#{ends_at}'}
  end

  ## methods
  it { expect(subject.to_s).to eq "#{subject.team_home} vs #{subject.team_away}" }

  context '#bettable?' do
    it 'in the future' do
      subject.played_at = Time.current + 1
      expect(subject.bettable?).to eq true
    end

    it 'in the past' do
      subject.played_at = Time.current - 1
      expect(subject.bettable?).to eq false
    end
  end

  ## methods
  context '#played?' do
    it 'in the future' do
      subject.played_at = Time.current + 1
      expect(subject.played?).to eq false
    end

    it 'in the past' do
      subject.played_at = Time.current - 1
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
