class Bet < ActiveRecord::Base
  ## associations
  belongs_to :user
  belongs_to :game

  ## validations
  validates :user, presence: true
  validates :game, presence: true
  validates :team_home_goals, presence: true, numericality: { greater_than_or_equal_to: 0 }, on: :update
  validates :team_away_goals, presence: true, numericality: { greater_than_or_equal_to: 0 }, on: :update
  validate  :only_bettable

  ## delegates
  delegate :played_at, to: :game
  delegate :bettable?, to: :game, allow_nil: true
  delegate :team_home, to: :game
  delegate :team_away, to: :game

  ## methods
  def goals?
    team_home_goals.present? and team_away_goals.present?
  end

  def to_s
    "#{team_home.short_name} vs #{team_away.short_name}"
  end

private
  def only_bettable
    if not bettable? and (team_home_goals_changed? or team_away_goals_changed?)
      errors.add(:base, "The game was played and now isn't bettable")
    end
  end
end
