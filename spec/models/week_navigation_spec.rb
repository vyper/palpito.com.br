require 'spec_helper'

describe WeekNavigation do
  fixtures :championships

  let(:championship) { championships(:worldcup) }
  let(:week)         { WeekNavigation.new(championship) }
  let(:week_w_n)     { WeekNavigation.new(championship, 25) }

  context '#number' do
    it('max limit')           { expect(WeekNavigation.new(championship, 66).number).to eq 28 }
    it('min limit')           { expect(WeekNavigation.new(championship, -3).number).to eq 24 }
    it('empty')               { expect(WeekNavigation.new(championship).number).    to eq 24 }
  end

  it('#min_number_limit') { expect(week.min_number_limit).to eq 24 }
  it('#max_number_limit') { expect(week.max_number_limit).to eq 28 }

  context '#start' do
    it { expect(week.start).to     eq Time.parse("2014-06-09 00:00:00") }
    it { expect(week_w_n.start).to eq Time.parse("2014-06-16 00:00:00") }
  end

  context '#finish' do
    it { expect(week.finish).to     eq Time.parse("2014-06-15 23:59:59") }
    it { expect(week_w_n.finish).to eq Time.parse("2014-06-22 23:59:59") }
  end

  it('#next?') { expect(week.next?).to eq true }

  context '#next' do
    it { expect(week.next).to     eq 25 }
    it { expect(week_w_n.next).to eq 26 }
  end

  it('#previous?') { expect(week.previous?).to eq false }

  context '#previous' do
    it { expect(week.previous).to     eq 23 }
    it { expect(week_w_n.previous).to eq 24 }
  end

  context '#to_range' do
    it { expect(week.to_range).to     eq (Time.parse("2014-06-09 00:00:00")..Time.parse("2014-06-15 23:59:59")) }
    it { expect(week_w_n.to_range).to eq (Time.parse("2014-06-16 00:00:00")..Time.parse("2014-06-22 23:59:59")) }
  end
end
