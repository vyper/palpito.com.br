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

  def previous
    raise "Not implemented"
  end

  def next
    raise "Not implemented"
  end
end
