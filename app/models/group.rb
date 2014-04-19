class Group < ActiveRecord::Base
  ## associations
  belongs_to :admin, class_name: User
  belongs_to :championship

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
