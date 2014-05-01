require 'spec_helper'

describe Round do
  fixtures :rounds

  subject { rounds(:first) }

  ## associations
  it { expect(subject).to belong_to(:championship) }
  it { expect(subject).to have_many(:games).dependent(:restrict_with_error) }
  it { expect(subject).to have_many(:teams_home).through(:games).source(:team_home) }
  it { expect(subject).to have_many(:teams_away).through(:games).source(:team_away) }

  ## validations
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:championship) }

  ## methods
  it { expect(subject.to_s).to eq subject.name }
  it { expect(subject.teams).to eq (subject.teams_home + subject.teams_away) }
end
