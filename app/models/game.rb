class Game < ActiveRecord::Base
  ## associations
  belongs_to :team_home, class_name: Team
  belongs_to :team_away, class_name: Team
  belongs_to :round
  has_many   :bets, dependent: :restrict_with_error

  ## validations
  validates :played_at, presence: true
  validates :team_home, presence: true
  validates :team_away, presence: true
  validates :round,     presence: true
  validates :team_home_goals, presence: true, if: :played?
  validates :team_away_goals, presence: true, if: :played?
  validates :team_home_goals, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :team_away_goals, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validate  :only_one_game_of_the_team_in_round

  ## delegates
  delegate :championship, to: :round

  ## scopes
  scope :not_played, -> { where('"games"."played_at" < ?', DateTime.now) }

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
  def only_one_game_of_the_team_in_round
    if team_home.present? and team_home_id_changed? and round.teams.include? team_home
      errors.add(:team_home, "Team home already exists in the round")
    end

    if team_away.present? and team_away_id_changed? and round.teams.include? team_away
      errors.add(:team_away, "Team away already exists in the round")
    end
  end
end
