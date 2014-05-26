require 'spec_helper'

describe 'Rounds' do
  fixtures :users, :rounds, :championships

  before(:each) { login_as(users(:vyper), scope: :user, run_callbacks: false) }

  it 'listing' do
    visit '/rounds'

    expect(page).to have_content "1ª"
    expect(page).to have_content "Copa do Mundo"
    expect(page).to have_content "2ª"
  end

  it 'creating' do
    visit '/rounds/new'

    fill_in 'round_name', with: '3ª'
    select '1', from: 'round[championship_id]'
    click_on 'Salvar'

    expect(page).to have_content '3ª'
    expect(page).to have_content "Rodada '3ª' salva com sucesso"
  end

  it 'updating' do
    visit "/rounds/#{rounds(:first).id}/edit"

    fill_in 'round_name', with: '3ª'
    select '1', from: 'round[championship_id]'
    click_on 'Salvar'

    expect(page).not_to have_content '1ª'
    expect(page).to have_content '3ª'
    expect(page).to have_content "Rodada '3ª' salva com sucesso"
  end

  it 'destroying' do
    visit '/rounds'

    expect {
      all("a:last[data-method='delete']").last.click
    }.to change(Round, :count).by(-1)
  end
end
