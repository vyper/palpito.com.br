require 'rails_helper'

RSpec.describe WeekNavigation do
  fixtures :championships

  context 'championship with only one year' do
    let(:championship) { championships(:worldcup) }

    subject { described_class.new(championship: championship, day: day) }

    context 'use today when day is null' do
      let(:day)      { nil }
      let(:base_day) { championship.started_at.beginning_of_week }

      before do
        expect(Time).to receive(:current).and_return(Time.zone.parse('2014-01-01 00:00:00'))
      end

      it('#current')   { expect(subject.current).to eq base_day }
      it('#week')      { expect(subject.week).to eq base_day.to_date.cweek }
      it('#next')      { expect(subject.next).to eq base_day + 8.days }
      it('#next?')     { expect(subject.next?).to be_truthy }
      it('#previous')  { expect(subject.previous).to eq base_day - 1.day }
      it('#previous?') { expect(subject.previous?).to be_falsey }
      it('#to_range')  { expect(subject.to_range).to eq base_day..base_day.end_of_week }
    end

    context 'use today when day is empty' do
      let(:day)      { '' }
      let(:base_day) { championship.started_at.beginning_of_week }

      before do
        expect(Time).to receive(:current).and_return(Time.zone.parse('2014-01-01 00:00:00'))
      end

      it('#current')   { expect(subject.current).to eq base_day }
      it('#week')      { expect(subject.week).to eq base_day.to_date.cweek }
      it('#next')      { expect(subject.next).to eq base_day + 8.days }
      it('#next?')     { expect(subject.next?).to be_truthy }
      it('#previous')  { expect(subject.previous).to eq base_day - 1.day }
      it('#previous?') { expect(subject.previous?).to be_falsey }
      it('#to_range')  { expect(subject.to_range).to eq base_day..base_day.end_of_week }
    end

    context 'day is before of championship' do
      let(:day)      { '2014-01-01 00:00:00' }
      let(:base_day) { championship.started_at.beginning_of_week }

      it('#current')   { expect(subject.current).to eq base_day }
      it('#week')      { expect(subject.week).to eq base_day.to_date.cweek }
      it('#next')      { expect(subject.next).to eq base_day + 8.days }
      it('#next?')     { expect(subject.next?).to be_truthy }
      it('#previous')  { expect(subject.previous).to eq base_day - 1.day }
      it('#previous?') { expect(subject.previous?).to be_falsey }
      it('#to_range')  { expect(subject.to_range).to eq base_day..base_day.end_of_week }
    end

    context 'day is during of championship' do
      let(:day)      { '2014-06-18 00:00:00' }
      let(:base_day) { Time.zone.parse(day).beginning_of_week }

      it('#current')   { expect(subject.current).to eq base_day }
      it('#week')      { expect(subject.week).to eq base_day.to_date.cweek }
      it('#next')      { expect(subject.next).to eq base_day + 8.days }
      it('#next?')     { expect(subject.next?).to be_truthy }
      it('#previous')  { expect(subject.previous).to eq base_day - 1.day }
      it('#previous?') { expect(subject.previous?).to be_truthy }
      it('#to_range')  { expect(subject.to_range).to eq base_day.beginning_of_week..base_day.end_of_week }
    end

    context 'day is after of championship' do
      let(:day)      { '2014-08-01 00:00:00' }
      let(:base_day) { championship.finished_at.beginning_of_week }

      it('#current')   { expect(subject.current).to eq base_day }
      it('#week')      { expect(subject.week).to eq base_day.to_date.cweek }
      it('#next')      { expect(subject.next).to eq base_day + 8.days }
      it('#next?')     { expect(subject.next?).to be_falsey }
      it('#previous')  { expect(subject.previous).to eq base_day - 1.day }
      it('#previous?') { expect(subject.previous?).to be_truthy }
      it('#to_range')  { expect(subject.to_range).to eq base_day..base_day.end_of_week }
    end
  end

  context 'championship with two years' do
    let(:championship) { championships(:premier_league) }

    subject { described_class.new(championship: championship, day: day) }

    context 'day is before of championship' do
      let(:day)      { '2016-07-01 00:00' }
      let(:base_day) { championship.started_at.beginning_of_week }

      it('#current')   { expect(subject.current).to eq base_day }
      it('#week')      { expect(subject.week).to eq base_day.to_date.cweek }
      it('#next')      { expect(subject.next).to eq base_day + 8.days }
      it('#next?')     { expect(subject.next?).to be_truthy }
      it('#previous')  { expect(subject.previous).to eq base_day - 1.day }
      it('#previous?') { expect(subject.previous?).to be_falsey }
      it('#to_range')  { expect(subject.to_range).to eq base_day..base_day.end_of_week }
    end

    context 'day is during of championship' do
      let(:day)      { '2016-09-13 00:00' }
      let(:base_day) { Time.zone.parse(day).beginning_of_week }

      it('#current')   { expect(subject.current).to eq base_day }
      it('#week')      { expect(subject.week).to eq base_day.to_date.cweek }
      it('#next')      { expect(subject.next).to eq base_day + 8.days }
      it('#next?')     { expect(subject.next?).to be_truthy }
      it('#previous')  { expect(subject.previous).to eq base_day - 1.day }
      it('#previous?') { expect(subject.previous?).to be_truthy }
      it('#to_range')  { expect(subject.to_range).to eq base_day.beginning_of_week..base_day.end_of_week }
    end

    context 'day is after of championship' do
      let(:day)      { '2017-08-13 00:00' }
      let(:base_day) { championship.finished_at.beginning_of_week }

      it('#current')   { expect(subject.current).to eq base_day }
      it('#week')      { expect(subject.week).to eq base_day.to_date.cweek }
      it('#next')      { expect(subject.next).to eq base_day + 8.days }
      it('#next?')     { expect(subject.next?).to be_falsey }
      it('#previous')  { expect(subject.previous).to eq base_day - 1.day }
      it('#previous?') { expect(subject.previous?).to be_truthy }
      it('#to_range')  { expect(subject.to_range).to eq base_day..base_day.end_of_week }
    end
  end
end
