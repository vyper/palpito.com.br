require 'spec_helper'

describe ClassifyGameWorker do
  fixtures :games, :bets

  it '#perform' do
    ClassifyBetWorker.should_receive(:perform_async).with(bets(:sao_w_x_par).id).once
    subject.perform games(:sao_x_par).id
  end
end
