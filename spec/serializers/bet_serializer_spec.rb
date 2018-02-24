require 'rails_helper'

RSpec.describe BetSerializer do
  fixtures :bets, :games, :teams

  let(:bet) { bets(:sao_w_x_par) }
  let(:game) { bet.game }
  subject { described_class.new(bet) }

  ## methods
  it { expect(subject.weekday).to eq I18n.t("date.abbr_day_names")[game.played_at.strftime("%w").to_i] }
  it { expect(subject.time).to eq game.played_at.strftime("%H:%M") }
  it { expect(subject.date).to eq game.played_at.strftime("%d/%m") }
  it { expect(subject.team_home).to eq game.team_home.to_s }
  it { expect(subject.team_home_image_url).to eq game.team_home.image.url }
  it { expect(subject.team_away).to eq game.team_away.to_s }
  it { expect(subject.team_away_image_url).to eq game.team_away.image.url }
  it { expect(subject.game_team_home_goals).to eq game.team_home_goals }
  it { expect(subject.game_team_away_goals).to eq game.team_away_goals }

  it '#as_json' do
    expect(subject.as_json).to eq({
      id: bet.id,
      team_home_goals: 1,
      team_away_goals: 0,
      points: nil,
      is_bettable: false,
      label: nil,
      team_home: "São Paulo",
      team_home_short: "SAO",
      team_away: "Paraná",
      team_away_short: "PAR",
      team_home_image_url: game.team_home.image.url,
      team_away_image_url: game.team_away.image.url,
      weekday: "Qua",
      time: game.played_at.strftime("%H:%M"),
      date: game.played_at.strftime("%d/%m"),
      game_team_home_goals: 1,
      game_team_away_goals: 0
    })
  end
end
