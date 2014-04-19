require 'spec_helper'

describe Member do
  ## associations
  it { expect(subject).to belong_to(:group) }
  it { expect(subject).to belong_to(:user) }

  ## validations
  it { expect(subject).to validate_presence_of(:group) }
  it { expect(subject).to validate_presence_of(:user) }
  it { expect(subject).to validate_presence_of(:status) }

  ## attributes
  it { expect(Member::statuses).to eq({"active" => 0, "pending" => 1, "invited" => 2}) }

  ## scopes
  it { expect(Member.active.to_sql).to include '"members"."status" = 0' }
  it { expect(Member.pending.to_sql).to include '"members"."status" = 1' }
end
