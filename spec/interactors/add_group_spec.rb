require 'rails_helper'

RSpec.describe AddGroup, type: :interactor do
  fixtures :championships, :users

  context '.call' do
    it 'with valid group' do
      params = { name: "Add Group", championship: championships(:worldcup) }
      subject = AddGroup.call(params: params, user: users(:vyper))

      expect(subject.group.persisted?).to eq true
    end

    it 'with invalid group' do
      params = { name: nil, championship: championships(:worldcup) }
      subject = AddGroup.call(params: params, user: users(:vyper))

      expect(subject.group.persisted?).to eq false
    end

    it 'my own group' do
      params = { name: "Add Group", championship: championships(:worldcup) }
      subject = AddGroup.call(params: params, user: users(:vyper))

      expect(subject.group.admin).to eq users(:vyper)
    end
  end
end
