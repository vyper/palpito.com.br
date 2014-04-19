require 'spec_helper'

describe MemberForm do
  ## validations
  it { expect(subject).to validate_presence_of(:email) }
  it { expect(subject).to validate_presence_of(:group) }
end
