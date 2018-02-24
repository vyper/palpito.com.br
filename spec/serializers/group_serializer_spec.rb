require 'rails_helper'

RSpec.describe GroupSerializer do
  fixtures :groups, :championships

  let(:group) { groups(:vyper) }
  let(:championship) { group.championship }
  subject { described_class.new(group) }

  it '#as_json' do
    expect(subject.as_json).to eq({
      id: group.id, name: group.name,
      championship: { id: championship.id, name: championship.name }
    })
  end
end
