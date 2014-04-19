require 'spec_helper'

describe AddMyMemberOnOwnGroup do
  fixtures :groups, :users

  it '.perform' do
    group = groups(:vyper)
    user  = users(:vyper)

    subject = AddMyMemberOnOwnGroup.perform(group: group, user: user)
    expect(group.users.include?(user)).to eq true
  end
end
