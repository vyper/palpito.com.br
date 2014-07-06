require 'spec_helper'

describe Team do
  fixtures :teams

  subject { teams(:sao) }

  ## validations
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_uniqueness_of(:name) }
  it { expect(subject).to ensure_length_of(:name).is_at_least(3).is_at_most(50) }

  it { expect(subject).to validate_presence_of(:short_name) }
  it { expect(subject).to ensure_length_of(:short_name).is_at_least(3).is_at_most(3) }

  it { expect(subject).to validate_attachment_presence(:image) }
  it { expect(subject).to validate_attachment_content_type(:image).allowing('image/png', 'image/gif', 'image/jpg') }

  ## scopes
  it { expect(Team.all.to_sql).to include('"teams"."name"') }

  ## methods
  it { expect(subject.to_s).to eq subject.name }
end
