require 'spec_helper'

describe "UserSessions" do
  fixtures :users, :teams

  it "sign me in" do
    visit '/entrar'
    within('#new_user') do
      fill_in 'user_email',    with: 'vyper@maneh.org'
      fill_in 'user_password', with: 'super-senha'
    end
    click_on 'Entrar!'
    expect(page).to have_content 'Login efetuado com sucesso!'
  end

  it "sign me up" do
    visit '/cadastrar'
    within('#new_user') do
      fill_in 'user_nickname',   with: 'leo'
      fill_in 'user_first_name', with: 'Leonardo'
      fill_in 'user_last_name',  with: 'Saraiva'
      fill_in 'user_email',      with: 'leonardo@papodeboleiro.com'
      fill_in 'user_password',   with: 'super-senha'
      fill_in 'user_password_confirmation', with: 'super-senha'
    end
    click_on 'Cadastrar-se'

    expect(page).to have_content 'Antes de continuar, confirme a sua conta'
  end
end
