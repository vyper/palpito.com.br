require 'spec_helper'

describe ClassifyGroupWorker do
  fixtures :groups, :members, :users, :bets, :games, :championships

  let(:group)  { groups(:vyper) }
  let(:member) { members(:vyper) }
  let(:bet)    { bets(:sao_w_x_par) }

  it '#perform' do
    bet.update points: 40

    expect {
      subject.perform(group.id)
    }.to change { member.reload.points }.from(0).to(40)
  end
end
