require 'spec_helper'

RSpec.describe Member, type: :model do
  fixtures :members, :users, :groups

  subject { members(:vyper) }

  ## associations
  it { expect(subject).to belong_to(:group) }
  it { expect(subject).to belong_to(:user) }

  ## validations
  it { expect(subject).to validate_uniqueness_of(:group).scoped_to(:user_id) }
  it { expect(subject).to validate_presence_of(:group) }
  it { expect(subject).to validate_presence_of(:user) }
  it { expect(subject).to validate_presence_of(:status) }

  ## attributes
  it { is_expected.to define_enum_for(:status).with({ active: 0, pending: 1, invited: 2 }) }

  ## delegates
  it do
    user = users(:vyper)

    expect(subject.email).to eq user.email
    expect(subject.nickname).to eq user.nickname
    expect(subject.full_name).to eq user.full_name
    expect(subject.to_s).to eq user.to_s
  end
end
