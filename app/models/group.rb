class Group < ActiveRecord::Base
  ## associations
  belongs_to :admin, class_name: User

  ## validations
  validates :name,  presence: true, uniqueness: true
  validates :admin, presence: true

  ## methods
  def to_s
    name
  end

  def admin? user
    user == admin
  end
end
