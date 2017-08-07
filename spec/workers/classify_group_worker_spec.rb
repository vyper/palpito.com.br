require 'rails_helper'

RSpec.describe ClassifyGroupWorker, type: :worker do
  fixtures :groups, :members, :users, :bets, :games, :championships

  let(:group)  { groups(:vyper) }
  let(:member) { members(:vyper) }
  let(:bet)    { bets(:sao_w_x_par) }

  describe '#perform' do
    before do
      bet.update points: 40
    end

    it 'updates points' do
      expect {
        subject.perform(group.id)
      }.to change { member.reload.points }.from(0).to(40)
    end

    it 'updates position' do
      expect {
        subject.perform(group.id)
      }.to change { member.reload.position }.from(0).to(1)
    end

    it 'updates positions history' do
      key = Date.current.strftime('%Y/%W')

      expect {
        subject.perform(group.id)
      }.to change { member.reload.positions[key] }.from(nil).to(1)
    end
  end
end
