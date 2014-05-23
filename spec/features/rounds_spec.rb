require 'spec_helper'

describe 'Rounds' do
  fixtures :users, :rounds

  before(:each) { login_as(users(:vyper), scope: :user, run_callbacks: false) }

  it '#index' do
    visit '/rounds'

    expect(page).to have_content "1ª"
    expect(page).to have_content "Copa do Mundo"
    expect(page).to have_content "2ª"
  end
end
