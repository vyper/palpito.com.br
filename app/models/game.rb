class Game < ApplicationRecord
  ## associations
  belongs_to :team_home, class_name: Team
  belongs_to :team_away, class_name: Team
  belongs_to :championship
  has_many   :bets, dependent: :restrict_with_error

  ## validations
  validates :played_at,    presence: true
  validates :team_home,    presence: true
  validates :team_away,    presence: true
  validates :championship, presence: true
  validates :team_home_goals, presence: true, if: :played?
  validates :team_away_goals, presence: true, if: :played?
  validates :team_home_goals, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :team_away_goals, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validate  :only_accept_goals_on_played_game

  ## scopes
  scope :played, -> { where(arel_table[:played_at].lt(Time.current)) }
  scope :of_day, -> { where(played_at: Date.today.beginning_of_day..Date.today.end_of_day)}

  ## methods
  def to_s
    "#{team_home} vs #{team_away}"
  end

  def played?
    played_at.present? and DateTime.now.in_time_zone > played_at
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

private
  def only_accept_goals_on_played_game
    if not played? and team_home_goals.present?
      errors.add(:team_home_goals, "Don't accept team home goals for game not played")
    end

    if not played? and team_away_goals.present?
      errors.add(:team_away_goals, "Don't accept team away goals for game not played")
    end
  end
end
