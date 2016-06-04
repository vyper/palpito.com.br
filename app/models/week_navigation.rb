class WeekNavigation
  attr_accessor :championship, :today, :number

  def initialize(championship, number = nil)
    if number.to_i > 0
      @number = number.to_i
    end

    @championship = championship
  end

  def start
    DateTime.commercial(year, number, 1, 0, 0, 0).to_time
  end

  def finish
    DateTime.commercial(year, number, 7, 23, 59, 59).to_time
  end

  def year
    championship.started_at.year
  end

  def now
    Time.zone.now
  end

  def number
    @number ||= now.strftime("%W").to_i

    @number = max_number_limit if @number > max_number_limit
    @number = min_number_limit if @number < min_number_limit

    @number
  end

  def min_number_limit
    championship.started_at.strftime("%W").to_i + 1
  end

  def max_number_limit
    championship.finished_at.strftime("%W").to_i + 1
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
