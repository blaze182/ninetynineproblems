require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask questions
} do
  
  given(:user) {create :user}

  scenario 'Authenticated user created question' do
    sign_in user

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question longer than 15 symbols'
    fill_in 'Body', with: 'Test body is definitely longer than 30 symbols of text'
    click_on 'Create'

    expect(page).to have_content 'Your question has successfully been created!'
  end

  scenario 'Unauthenticated user tries to create a question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
