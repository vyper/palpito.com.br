class Group < ApplicationRecord
  ## associations
  belongs_to :admin, class_name: User
  belongs_to :championship
  has_many   :members, dependent: :destroy
  has_many   :users, through: :members

  ## validations
  validates :name,         presence: true, uniqueness: { scope: :championship }
  validates :admin,        presence: true
  validates :championship, presence: true

  ## methods
  def to_s
    name
  end

  def admin? user
    user == admin
  end
end
