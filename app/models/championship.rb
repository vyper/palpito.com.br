class Championship < ActiveRecord::Base
  ## validations
  validates :name,        presence: true
  validates :started_at,  presence: true
  validates :finished_at, presence: true

  ## methods
  def finished?
    finished_at <= DateTime.now
  end

  def started?
    started_at <= DateTime.now
  end

  def to_s
    name
  end
end
