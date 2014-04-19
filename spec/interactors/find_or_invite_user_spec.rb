require 'spec_helper'

describe FindOrInviteUser do
  fixtures :users, :groups

  subject      { FindOrInviteUser.perform(member: member) }
  let(:user)   { users(:vyper) }
  let(:group)  { groups(:vyper) }

  context 'existent email' do
    let(:member) { MemberForm.new(email: user.email, group: group) }

    it { expect(subject.user).to eq user }
  end

  context 'inexistent email' do
    let(:member) { MemberForm.new(email: "whatever@mail.org", group: group) }

    it { expect(subject.user.email).to eq member.email }
  end
end