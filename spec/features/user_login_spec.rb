require 'rails_helper'

RSpec.feature "Visitor logs in from home page", type: :feature, js: true do
  
  # SETUP 
  before :each do
    @user = User.create!(
      name: 'test', 
      email: 'test@test.com', 
      password: 'thisismypassword',
      password_confirmation: 'thisismypassword'
    )
  end

  scenario "They click on login, fill out the form on the login page and they are logged in" do
    # ACT
    visit root_path
    click_on('Login')
    find('section.login')
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_on('Submit')
    find_link('Logout')

    # DEBUG
    # save_screenshot

    # VERIFY
    expect(page).to have_text 'Logout'
  end

end
