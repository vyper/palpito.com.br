require 'spec_helper'

RSpec.describe ClassifyGroupsWorker, type: :worker do
  fixtures :groups

  describe '#perform' do
    it 'classify group for running championship' do
      expect(ClassifyGroupWorker).to receive(:perform_async).with(groups(:running).id)

      subject.perform
    end

    it 'does not classify group for finished championship' do
      expect(ClassifyGroupWorker).to_not receive(:perform_async).with(groups(:finished).id)

      subject.perform
    end

    it 'does not classify group for scheduled championship' do
      expect(ClassifyGroupWorker).to_not receive(:perform_async).with(groups(:scheduled).id)

      subject.perform
    end
  end
end
