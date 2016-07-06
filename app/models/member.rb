class Member < ApplicationRecord
  ## associations
  belongs_to :group
  belongs_to :user

  ## validations
  validates :group,        presence: true, uniqueness: { scope: :user }
  validates :user,         presence: true
  validates :status,       presence: true

  ## attributes
  enum status: { active: 0, pending: 1, invited: 2 }

  ## delegates
  delegate :nickname,  to: :user
  delegate :full_name, to: :user
  delegate :email,     to: :user
  delegate :to_s,      to: :user
end
