require 'spec_helper'

describe Bet do
  ## associations
  it { expect(subject).to belong_to(:user) }
  it { expect(subject).to belong_to(:game) }

  ## validations
  it { expect(subject).to validate_presence_of(:user) }
  it { expect(subject).to validate_presence_of(:game) }
  it { expect(subject).to validate_presence_of(:team_home_goals) }
  it { expect(subject).to validate_presence_of(:team_away_goals) }
  it { expect(subject).to ensure_length_of(:team_home_goals).is_at_least(0) }
  it { expect(subject).to ensure_length_of(:team_away_goals).is_at_least(0) }

  ## methods
  it '#to_s' do
    subject = build_stubbed(:bet)

    expect(subject.to_s).to eq "#{subject.game.team_home.short_name} vs #{subject.game.team_away.short_name}"
  end

  context '#goals?' do
    subject { Bet.new attributes_for(:bet) }

    it 'with goals' do
      expect(subject.goals?).to eq true
    end

    it 'without goals' do
      subject.team_home_goals = nil

      expect(subject.goals?).to eq false
    end
  end
end
