require 'spec_helper'

describe BetSerializer do
  fixtures :bets, :games, :teams, :rounds

  subject { BetSerializer.new(bets(:sao_w_x_par)) }
  let(:game) { games(:sao_x_par) }

  ## methods
  it { expect(subject.round).to eq rounds(:first).to_s }
  it { expect(subject.weekday).to eq I18n.t("date.abbr_day_names")[game.played_at.strftime("%w").to_i] }
  it { expect(subject.time).to eq game.played_at.strftime("%H:%M") }
  it { expect(subject.date).to eq game.played_at.strftime("%d/%m") }
  it { expect(subject.team_home).to eq game.team_home.to_s }
  it { expect(subject.team_home_image_url).to eq game.team_home.image.url }
  it { expect(subject.team_away).to eq game.team_away.to_s }
  it { expect(subject.team_away_image_url).to eq game.team_away.image.url }
  it { expect(subject.game_team_home_goals).to eq game.team_home_goals }
  it { expect(subject.game_team_away_goals).to eq game.team_away_goals }

  it { expect(subject.as_json).to eq({ id: 628721556, team_home_goals: 1, team_away_goals: 0, points: nil, is_bettable: false, label: nil, team_home: "São Paulo", team_home_short: "SAO", team_away: "Paraná", team_away_short: "PAR", round: "1ª", team_home_image_url: "/system/teams/images/136/128/820/original/spec/support/test.png", team_away_image_url: "/system/teams/images/694/025/141/original/spec/support/test.png", weekday: "Qua", time: "15:00", date: "01/01", game_team_home_goals: 1, game_team_away_goals: 0 }) }
end
