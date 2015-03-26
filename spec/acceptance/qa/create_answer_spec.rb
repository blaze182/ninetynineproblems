require 'rails_helper'

feature 'Create answer', %q{
  In order to provide help and get respect from community
  As an authenticated user
  I want to be able to propose answer for question
} do

  given(:user) {create :user}
  given!(:question) {create :question}

  scenario 'Authenticated user creates answer' do
    sign_in user
    
    visit questions_path
    click_on question.title
    fill_in 'Your answer', with: 'This is the answer bigger than 30 symbols'
    click_on 'Post your answer'
    expect(page).to have_content 'Your answer has successfully been added!'
  end
  scenario 'Unauthenticated user tries to create answer'

end