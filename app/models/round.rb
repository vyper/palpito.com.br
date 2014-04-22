class Round < ActiveRecord::Base
  ## associations
  belongs_to :championship

  ## validations
  validates :name,         presence: true
  validates :championship, presence: true

  ## methods
  def to_s
    name
  end
end
