require 'spec_helper'

describe ClassifyBetWorker do
  fixtures :bets

  it '#perform' do
    expect {
      subject.perform(bets(:sao_w_x_par))
    }.to change { Bet.find(bets(:sao_w_x_par).id).points }.from(nil).to(40)
  end
end
