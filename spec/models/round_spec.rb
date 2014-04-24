require 'spec_helper'

describe Round do
  fixtures :rounds

  subject { rounds(:first) }

  ## associations
  it { expect(subject).to belong_to(:championship) }
  it { expect(subject).to have_many(:games) }

  ## validations
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:championship) }

  ## methods
  it { expect(subject.to_s).to eq subject.name }
end
