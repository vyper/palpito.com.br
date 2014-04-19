require 'spec_helper'

describe InviteUserToGroup do
  fixtures :users, :groups

  subject      { InviteUserToGroup.perform(user: user, group: group) }
  let(:user)   { users(:vyper) }
  let(:group)  { groups(:vyper) }

  it { expect(group.users.include?(user)).to eq true }

  context 'my own group' do
    it { expect(subject.member.active?).to eq true }
  end

  context 'invited group' do
    subject { InviteUserToGroup.perform(user: users(:vpr), group: group) }

    it { expect(subject.member.invited?).to eq true }
  end
end
