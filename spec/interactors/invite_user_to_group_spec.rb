require 'rails_helper'

RSpec.describe InviteUserToGroup, type: :interactor do
  fixtures :users, :members, :groups

  subject      { InviteUserToGroup.call(user: user, group: group) }
  let(:user)   { users(:vyper) }
  let(:group)  { groups(:vyper) }

  it { expect(group.users.include?(user)).to eq true }

  context 'my own group' do
    it { expect(subject.member.active?).to eq true }
  end

  context 'invited group' do
    subject { InviteUserToGroup.call(user: users(:vpr), group: group) }

    it { expect(subject.member.invited?).to eq true }
  end

  it 'send with user_invited is true'
  it 'dont send with user_invited is false'
end
