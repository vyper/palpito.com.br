require 'spec_helper'

describe User do
  subject { build(:user) }

  ## validations
  it { expect(subject).to validate_presence_of(:nickname) }
  it 'validate_uniqueness_of(:nickname)'
  it { expect(subject).to ensure_length_of(:nickname).is_at_least(2).is_at_most(15) }
  it { expect(subject).to validate_presence_of(:first_name) }
  it { expect(subject).to validate_presence_of(:last_name) }
  it { expect(subject).to validate_presence_of(:team) }

  ## associations
  it { expect(subject).to belong_to(:team) }

  ## methods
  it { expect(subject.to_s).to eq "vyper" }
  it { expect(subject.name).to eq "Leonardo S." }
  it { expect(subject.full_name).to eq "Leonardo Saraiva" }
end
