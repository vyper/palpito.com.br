class WeekNavigation
  attr_accessor :championship, :number

  def initialize(championship, number = nil)
    if number.to_i > 0
      @number = number.to_i
    end

    @championship = championship
  end

  def start
    Date.commercial(year, number, 1).beginning_of_day
  end

  def finish
    Date.commercial(year, number, 7).end_of_day
  end

  def year
    championship.started_at.year
  end

  def now
    Time.zone.now
  end

  def number
    @number ||= now.to_date.cweek

    @number = max_number_limit if @number > max_number_limit
    @number = min_number_limit if @number < min_number_limit

    @number
  end

  def min_number_limit
    championship.started_at.to_date.cweek
  end

  def max_number_limit
    championship.finished_at.to_date.cweek
  end

  def next
    number + 1
  end

  def next?
    self.next <= max_number_limit
  end

  def previous
    number - 1
  end

  def previous?
    self.previous >= min_number_limit
  end

  def to_range
    start..finish
  end
end
