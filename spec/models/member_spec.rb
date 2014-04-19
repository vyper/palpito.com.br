require 'spec_helper'

describe Member do
  fixtures :members, :users
  subject { members(:vyper) }

  ## associations
  it { expect(subject).to belong_to(:group) }
  it { expect(subject).to belong_to(:user) }

  ## validations
  it { expect(subject).to validate_uniqueness_of(:group) } # TODO .scoped_to(:user_id)
  it { expect(subject).to validate_presence_of(:group) }
  it { expect(subject).to validate_presence_of(:user) }
  it { expect(subject).to validate_presence_of(:status) }

  ## attributes
  it { expect(Member::statuses).to eq({"active" => 0, "pending" => 1, "invited" => 2}) }

  ## delegates
  it do
    user = users(:vyper)

    expect(subject.email).to eq user.email
    expect(subject.nickname).to eq user.nickname
    expect(subject.full_name).to eq user.full_name
  end

  ## scopes
  it { expect(Member.active.to_sql).to include '"members"."status" = 0' }
  it { expect(Member.pending.to_sql).to include '"members"."status" = 1' }
end
