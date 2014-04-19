require 'spec_helper'

describe Group do
  fixtures :groups, :users

  subject { groups(:vyper) }

  ## associations
  it { expect(subject).to belong_to(:admin).class_name(User) }
  it { expect(subject).to belong_to(:championship) }
  it { expect(subject).to have_many(:members) }
  it { expect(subject).to have_many(:users).through(:members) }

  ## validations
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_uniqueness_of(:name).scoped_to(:championship_id) }
  it { expect(subject).to validate_presence_of(:admin) }

  ## methods
  it { expect(subject.to_s).to eq subject.name }

  context '#admin?' do
    it 'same user' do
      expect(subject.admin?(users(:vyper))).to eq true
    end

    it 'other user' do
      expect(subject.admin?(users(:vpr))).to eq false
    end
  end
end