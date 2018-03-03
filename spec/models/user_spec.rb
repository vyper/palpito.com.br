require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users

  subject { users(:vyper) }

  ## validations
  it { expect(subject).to validate_presence_of(:nickname) }
  it { expect(subject).to validate_uniqueness_of(:nickname) }
  it { expect(subject).to validate_length_of(:nickname).is_at_least(2).is_at_most(15) }
  it { expect(subject).to validate_presence_of(:first_name) }
  it { expect(subject).to validate_presence_of(:last_name) }

  ## associations
  it { expect(subject).to belong_to(:team) }
  it { expect(subject).to have_many(:bets) }
  it { expect(subject).to have_many(:members) }
  it { expect(subject).to have_many(:my_groups).class_name(Group).with_foreign_key(:admin_id) }
  it { expect(subject).to have_many(:groups).through(:members) }

  ## scopes
  it { expect(User.confirmed.to_sql).to include '("users"."confirmed_at" IS NOT NULL)' }

  ## methods
  it { expect(subject.to_s).to eq "vyper" }
  it { expect(subject.name).to eq "Leonardo S." }
  it { expect(subject.full_name).to eq "Leonardo Saraiva" }

  context '#facebooked?' do
    it 'all fields filled' do
      expect(subject.facebooked?).to eq true
    end

    it 'only provider' do
      subject.uid = nil
      expect(subject.facebooked?).to eq false
    end

    it 'only uid' do
      subject.provider = nil
      expect(subject.facebooked?).to eq false
    end
  end

  context '.from_facebook_oauth' do
    let(:info) { OpenStruct.new(email: "oauth@info.org", first_name: "First", last_name: "Last") }
    let(:auth) { OpenStruct.new(info: info, provider: "facebook", uid: '12345') }

    it 'non existent email' do
      user = nil
      expect do
        user = User.from_facebook_oauth(auth)
      end.to change(User, :count).by(1)

      expect(user).to            be_confirmed
      expect(user.provider).to   eq auth.provider
      expect(user.uid).to        eq auth.uid
      expect(user.email).to      eq auth.info.email
      expect(user.first_name).to eq auth.info.first_name
      expect(user.last_name).to  eq auth.info.last_name
    end

    it 'existent email without provider and uid' do
      subject = users(:vpr)
      auth.info.email = subject.email

      user = nil
      expect do
        user = User.from_facebook_oauth(auth)
      end.to change(User, :count).by(0)

      expect(user).to            be_confirmed
      expect(user.provider).to   eq auth.provider
      expect(user.uid).to        eq auth.uid
      expect(user.email).to      eq subject.email
      expect(user.first_name).to eq subject.first_name
      expect(user.last_name).to  eq subject.last_name
    end

    it 'existent email with provider and uid' do
      subject = users(:vyper)
      auth.info.email = subject.email

      user = nil
      expect do
        user = User.from_facebook_oauth(auth)
      end.to change(User, :count).by(0)

      expect(user).to            be_confirmed
      expect(user.provider).to   eq subject.provider
      expect(user.uid).to        eq subject.uid
      expect(user.email).to      eq subject.email
      expect(user.first_name).to eq subject.first_name
      expect(user.last_name).to  eq subject.last_name
    end
  end
end
