require 'spec_helper'

RSpec.describe Member, type: :model do
  fixtures :members, :users, :groups

  subject { members(:vyper) }

  ## associations
  it { is_expected.to belong_to(:group) }
  it { is_expected.to belong_to(:user) }

  ## validations
  it { is_expected.to validate_uniqueness_of(:group).scoped_to(:user_id) }
  it { is_expected.to validate_presence_of(:group) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:status) }

  ## attributes
  it { is_expected.to define_enum_for(:status).with({ active: 0, pending: 1, invited: 2 }) }

  ## delegates
  it do
    user = users(:vyper)

    expect(subject.email).to eq user.email
    expect(subject.nickname).to eq user.nickname
    expect(subject.full_name).to eq user.full_name
    expect(subject.to_s).to eq user.to_s
  end

  ## methods
  describe '#rank_for!' do
    let(:key)      { day.strftime('%Y/%W') }
    let(:day)      { Time.current }
    let(:points)   { 30 }
    let(:position) { 1 }

    context 'when member has oldest ranking' do
      let(:oldest) { 2.week.ago.strftime('%Y/%W') }

      before do
        subject.update points: 10,
                       position: 2,
                       positions: { oldest => 2 }
      end

      it 'updates points' do
        expect {
          subject.rank_for! day, points: points, position: position
        }.to change { subject.reload.points }.from(10).to(30)
      end

      it 'updates position' do
        expect {
          subject.rank_for! day, points: points, position: position
        }.to change { subject.reload.position }.from(2).to(1)
      end

      it 'updates position history' do
        expect {
          subject.rank_for! day, points: points, position: position
        }.to change { subject.reload.positions[key] }.from(nil).to(1)
      end

      it 'maintains oldest position history' do
        expect {
          subject.rank_for! day, points: points, position: position
        }.to_not change { subject.reload.positions[oldest] }
      end
    end

    context 'when member is unranked' do
      it 'updates points' do
        expect {
          subject.rank_for! day, points: points, position: position
        }.to change { subject.reload.points }.from(0).to(30)
      end

      it 'updates position' do
        expect {
          subject.rank_for! day, points: points, position: position
        }.to change { subject.reload.position }.from(0).to(1)
      end

      it 'updates position history' do
        expect {
          subject.rank_for! day, points: points, position: position
        }.to change { subject.reload.positions[key] }.from(nil).to(1)
      end
    end

    context 'when member has newest ranking' do
      let(:newest) { 2.week.from_now.strftime('%Y/%W') }

      before do
        subject.update points: 10,
                       position: 2,
                       positions: { newest => 2 }
      end

      it 'maintains points' do
        expect {
          subject.rank_for! day, points: points, position: position
        }.to_not change { subject.reload.points }
      end

      it 'maintains position' do
        expect {
          subject.rank_for! day, points: points, position: position
        }.to_not change { subject.reload.position }
      end

      it 'updates position history' do
        expect {
          subject.rank_for! day, points: points, position: position
        }.to change { subject.reload.positions[key] }.from(nil).to(1)
      end

      it 'maintain newest position history' do
        expect {
          subject.rank_for! day, points: points, position: position
        }.to_not change { subject.reload.positions[newest] }
      end
    end
  end
end
