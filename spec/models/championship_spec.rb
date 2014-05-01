require 'spec_helper'

describe Championship do
  fixtures :championships

  ## validations
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:started_at) }
  it { expect(subject).to validate_presence_of(:finished_at) }

  ## associations
  it { expect(subject).to have_many(:groups).dependent(:restrict_with_error) }
  it { expect(subject).to have_many(:rounds).dependent(:restrict_with_error) }

  ## methods
  it { expect(subject.to_s).to eq subject.name }

  context '#started?' do
    subject { championships(:worldcup) }

    it 'in the past' do
      subject.started_at = Time.now - 1
      expect(subject.started?).to eq true
    end

    it 'in the future' do
      subject.started_at = Time.now + 1
      expect(subject.started?).to eq false
    end
  end

  context '#finished?' do
    subject { championships(:worldcup) }

    it 'finished in the past' do
      subject.finished_at = Time.now - 1
      expect(subject.finished?).to eq true
    end

    it 'finish in the future' do
      subject.finished_at = Time.now + 1
      expect(subject.finished?).to eq false
    end
  end
end
