require 'spec_helper'

describe Group do
  ## associations
  it { expect(subject).to belong_to(:admin).class_name(User) }
  it { expect(subject).to belong_to(:championship) }
  it { expect(subject).to have_many(:members) }

  ## validations
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_uniqueness_of(:name).scoped_to(:championship_id) }
  it { expect(subject).to validate_presence_of(:admin) }

  ## methods
  it { expect(subject.to_s).to eq subject.name }

  context '#admin?' do
    it 'same user' do
      subject = build_stubbed(:group)

      expect(subject.admin?(subject.admin)).to eq true
    end

    it 'other user' do
      subject = build_stubbed(:group)
      user    = User.new attributes_for(:other_user)

      expect(subject.admin?(user)).to eq false
    end
  end
end