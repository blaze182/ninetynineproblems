require 'rails_helper'

feature 'User sign in', %q{
  In order to ask questions
  As an User
  I want to be able to sign in
} do

  scenario 'Registered user tries to sign in' do
    User.create!(email: 'user@example.com', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end
  
  scenario 'Unregistered user tries to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong_user@example.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid email or password'
    expect(current_path).to eq new_user_session_path
  end
end