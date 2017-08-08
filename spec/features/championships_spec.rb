require 'rails_helper'

RSpec.describe 'Championships', type: :feature do
  fixtures :users, :championships

  before(:each) { login_as(users(:vyper), scope: :user, run_callbacks: false) }

  it 'listing' do
    visit '/championships'

    expect(page).to have_content "Copa do Mundo"
  end

  it 'creating' do
    visit '/championships/new'

    fill_in 'championship_name',        with: 'Campeonato Brasileiro 2014'
    fill_in 'championship_started_at',  with: -7.days.from_now
    fill_in 'championship_finished_at', with: 7.days.from_now
    click_on 'Salvar'

    expect(page).to have_content 'Campeonato Brasileiro 2014'
    expect(page).to have_content "Campeonato 'Campeonato Brasileiro 2014' salvo com sucesso"
  end

  it 'updating' do
    visit "/championships/#{championships(:worldcup).id}/edit"

    fill_in 'championship_name',        with: 'World Cup 2014'
    fill_in 'championship_started_at',  with: -7.days.from_now
    fill_in 'championship_finished_at', with: 7.days.from_now
    click_on 'Salvar'

    expect(page).not_to have_content 'Copa do Mundo 2014'
    expect(page).to have_content 'World Cup 2014'
    expect(page).to have_content "Campeonato 'World Cup 2014' salvo com sucesso"
  end

  it 'destroying' # do
  #   visit '/championships'
  #   expect {
  #     all("a:last[data-method='delete']").last.click
  #   }.to change(Championship, :count).by(-1)
  # end
end
