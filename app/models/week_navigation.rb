class WeekNavigation
  attr_accessor :championship

  def initialize(championship:, day:)
    @day          = day.present? ? Time.zone.parse(day) : Time.current
    @championship = championship
  end

  def week
    current.to_date.cweek
  end

  def current
    @base_day ||= begin
      return championship.started_at.beginning_of_week if @day < championship.started_at
      return championship.finished_at.beginning_of_week if @day > championship.finished_at

      @day.beginning_of_week
    end
  end

  def next
    current + 8.days
  end

  def next?
    self.next <= championship.finished_at.end_of_week
  end

  def previous
    current - 1.day
  end

  def previous?
    self.previous >= championship.started_at.beginning_of_week
  end

  def start
    current.beginning_of_week
  end

  def finish
    current.end_of_week
  end

  def to_range
    start..finish
  end
end
