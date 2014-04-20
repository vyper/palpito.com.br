class Member < ActiveRecord::Base
  ## associations
  belongs_to :group
  belongs_to :user

  ## validations
  validates :group,        presence: true, uniqueness: { scope: :user }
  validates :user,         presence: true
  validates :status,       presence: true

  ## attributes
  enum status: [ :active, :pending, :invited ]

  ## delegates
  delegate :nickname,  to: :user
  delegate :full_name, to: :user
  delegate :email,     to: :user
  delegate :to_s,      to: :user

  ## scopes
  scope :active,  -> { where(status: Member::statuses[:active]) }
  scope :pending, -> { where(status: Member::statuses[:pending]) }
end
