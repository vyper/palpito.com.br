require 'spec_helper'

describe Round do
  fixtures :rounds

  subject { rounds(:first) }

  ## associations
  it { expect(subject).to belong_to(:championship) }

  ## validations
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:championship) }

  ## methods
  it { expect(subject.to_s).to eq subject.name }
  it '#previous'
  it '#next'
end
