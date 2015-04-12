require_relative '../acceptance_helper'

feature 'User sign up', %q{
  In order to be able to sign in to ask a question
  As unregistered user
  I want to be able to sign up
} do

  given(:user) {create :user}

  scenario 'Authenticated user tries to sign up' do
    sign_in user

    visit new_user_registration_path
    expect(page).to have_content "You are already signed in."
  end

  scenario 'Unregistered user tries to sign up with existing identity' do
    visit new_user_registration_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
    expect(page).to have_content "Email has already been taken"
  end

  scenario 'Unregistered user signs up' do
    visit new_user_registration_path

    fill_in 'Email', with: 'newuser@example.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'
    expect(page).to have_content "Welcome! You have signed up successfully."
  end

end