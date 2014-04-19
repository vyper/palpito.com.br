require 'spec_helper'

describe AddGroup do
  fixtures :championships, :users

  context '.perform' do
    it 'with valid group' do
      params = { name: "Add Group", championship: championships(:worldcup) }
      subject = AddGroup.perform(params: params, user: users(:vyper))

      expect(subject.group.persisted?).to eq true
    end

    it 'with invalid group' do
      params = { name: nil, championship: championships(:worldcup) }
      subject = AddGroup.perform(params: params, user: users(:vyper))

      expect(subject.group.persisted?).to eq false
    end

    it 'my own group' do
      params = { name: "Add Group", championship: championships(:worldcup) }
      subject = AddGroup.perform(params: params, user: users(:vyper))

      expect(subject.group.admin).to eq users(:vyper)
    end
  end
end