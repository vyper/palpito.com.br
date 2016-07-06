require 'spec_helper'

RSpec.describe Championship, type: :model do
  fixtures :championships

  ## validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:started_at) }
  it { is_expected.to validate_presence_of(:finished_at) }

  ## associations
  it { is_expected.to have_many(:groups).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:games).dependent(:restrict_with_error) }

  ## scopes
  describe '.running' do
    subject { described_class.running }

    it { is_expected.to_not include championships(:finished) }
    it { is_expected.to     include championships(:running) }
    it { is_expected.to_not include championships(:scheduled) }
  end

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
