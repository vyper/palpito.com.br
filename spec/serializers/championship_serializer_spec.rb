require 'rails_helper'

RSpec.describe ChampionshipSerializer do
  fixtures :championships

  let(:championship) { championships(:worldcup) }
  subject { described_class.new(championship) }

  it '#as_json' do
    expect(subject.as_json).to eq({ id: championship.id, name: championship.name })
  end
end
