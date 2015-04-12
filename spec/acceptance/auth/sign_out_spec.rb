require_relative '../acceptance_helper'

feature 'User sign out', %q{
  In order to destroy my session
  As an Authenticated user
  I want to be able to sign out
} do

  given(:user) {create :user}

  scenario 'Authenticated user signs out' do
    sign_in user

    visit destroy_user_session_path
    expect(page).to have_content "Signed out successfully."

    visit new_user_registration_path # testing if user is really signed out. If signed in, devise does not allow to sign up
    expect(page).not_to have_content "You are already signed in."
  end
end