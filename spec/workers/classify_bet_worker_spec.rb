require 'spec_helper'

describe ClassifyBetWorker do
  fixtures :bets

  let(:bet)  { bets(:sao_w_x_par) }

  it '#perform' do
    expect {
      subject.perform(bet.id)
    }.to change { bet.reload.points }.from(nil).to(40)
  end
end
