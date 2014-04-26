class Round < ActiveRecord::Base
  ## associations
  belongs_to :championship
  has_many   :games
  has_many   :teams_home, through: :games, source: :team_home
  has_many   :teams_away, through: :games, source: :team_away

  ## validations
  validates :name,         presence: true
  validates :championship, presence: true

  ## methods
  def to_s
    name
  end

  def teams
    teams_home + teams_away
  end
end
