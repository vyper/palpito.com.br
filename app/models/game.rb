class Game < ActiveRecord::Base
  ## associations
  belongs_to :team_home, class_name: Team
  belongs_to :team_away, class_name: Team
  belongs_to :round

  ## validations
  validates :played_at, presence: true
  validates :team_home, presence: true
  validates :team_away, presence: true
  validates :round,     presence: true
  validates :team_home_goals, numericality: { greater_than: -1 }
  validates :team_away_goals, numericality: { greater_than: -1 }

  ## methods
  def played?
    DateTime.now > played_at
  end

  def goals?
    team_home_goals.present? and team_away_goals.present?
  end

  def team_home_winner?
    team_home_goals > team_away_goals
  end

  def team_away_winner?
    team_away_goals > team_home_goals
  end

  def tied?
    team_home_goals == team_away_goals
  end

  def bettable?
    not played?
  end
end
