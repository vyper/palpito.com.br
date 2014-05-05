require 'spec_helper'

describe ClassifyGameWorker do
  fixtures :games, :bets

  context '#perform' do
    it 'have goals' do
      expect(ClassifyBetWorker).to receive(:perform_async).with(bets(:sao_w_x_par).id).once
      subject.perform games(:sao_x_par).id
    end

    it 'havent goals' do
      expect(ClassifyBetWorker).to_not receive(:perform_async)
      subject.perform games(:cor_x_pal).id
    end
  end
end
