class Member < ApplicationRecord
  ## associations
  belongs_to :group
  belongs_to :user

  ## validations
  validates :group,  presence: true, uniqueness: { scope: :user }
  validates :user,   presence: true
  validates :status, presence: true

  ## attributes
  enum status: { active: 0, pending: 1, invited: 2 }

  ## delegates
  delegate :nickname,  to: :user
  delegate :full_name, to: :user
  delegate :email,     to: :user
  delegate :to_s,      to: :user

  ## methods
  def rank_for!(day, points:, position:)
    if actual_position = positions.keys.reverse.first
      actual_position = Date.commercial(*actual_position.split('/').map(&:to_i))
    end

    if !actual_position || actual_position < day
      self.points = points
      self.position = position
    end

    self.positions[day.strftime('%Y/%W')] = position

    save!
  end

  def position_difference
    return 0 if positions.size < 2

    positions.sort.last(2).map(&:last).reduce(&:-)
  end
end
