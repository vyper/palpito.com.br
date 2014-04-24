class Round < ActiveRecord::Base
  ## associations
  belongs_to :championship
  has_many   :games

  ## validations
  validates :name,         presence: true
  validates :championship, presence: true

  ## methods
  def to_s
    name
  end
end
