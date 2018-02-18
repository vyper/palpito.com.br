class Championship < ApplicationRecord
  ## validations
  validates :name,        presence: true
  validates :started_at,  presence: true
  validates :finished_at, presence: true

  ## associations
  has_many :groups, dependent: :restrict_with_error
  has_many :games,  dependent: :restrict_with_error

  ## scopes
  scope :running, -> (on: Time.current) {  where(arel_table[:started_at].lteq(on.end_of_day))
                                          .where(arel_table[:finished_at].gteq(on.beginning_of_day)) }

  ## methods
  def finished?
    finished_at <= Time.current
  end

  def started?
    started_at <= Time.current
  end

  def to_s
    name
  end
end
