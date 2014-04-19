class Member < ActiveRecord::Base
  ## associations
  belongs_to :group
  belongs_to :user

  ## validations
  validates :group,        presence: true
  validates :user,         presence: true
  validates :status,       presence: true

  ## attributes
  enum status: [ :active, :pending, :invited ]

  ## scopes
  scope :active,  -> { where(status: Member::statuses[:active]) }
  scope :pending, -> { where(status: Member::statuses[:pending]) }
end
