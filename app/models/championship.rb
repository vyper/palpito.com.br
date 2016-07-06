class Championship < ApplicationRecord
  ## validations
  validates :name,        presence: true
  validates :started_at,  presence: true
  validates :finished_at, presence: true

  ## associations
  has_many :groups, dependent: :restrict_with_error
  has_many :games,  dependent: :restrict_with_error

  ## scopes
  scope :running, -> { where(arel_table[:started_at].lteq(Time.current))
                         .where(arel_table[:finished_at].gteq(Time.current)) }

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
