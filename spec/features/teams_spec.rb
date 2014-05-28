require 'spec_helper'

describe 'Teams' do
  fixtures :users, :teams

  before(:each) { login_as(users(:vyper), scope: :user, run_callbacks: false) }

  it '#index' do
    visit '/teams'

    expect(page).to have_content "São Paulo"
    expect(page).to have_content "Paraná"
  end

  it 'creating' do
    visit '/teams/new'

    fill_in 'team_short_name', with: 'BRA'
    fill_in 'team_name', with: 'Brasil'
    attach_file 'team_image', File.join('spec', 'support', 'test.png')
    click_on 'Salvar'

    expect(page).to have_content 'Brasil'
    expect(page).to have_content "Time 'Brasil' salvo com sucesso"
  end

  it 'updating' do
    visit "/teams/#{teams(:cor).id}/edit"

    fill_in 'team_short_name', with: 'COR'
    fill_in 'team_name', with: 'Galinhas'
    click_on 'Salvar'

    expect(page).not_to have_content 'Corinthians'
    expect(page).to have_content 'Galinhas'
    expect(page).to have_content "Time 'Galinhas' salvo com sucesso"
  end

  it 'destroying' do
    visit '/teams'

    expect {
      all("a:last[data-method='delete']").last.click
    }.to change(Team, :count).by(-1)
  end
end
