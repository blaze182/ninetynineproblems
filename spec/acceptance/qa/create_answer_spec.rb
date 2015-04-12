require_relative '../acceptance_helper'

feature 'Create answer', %q{
  In order to provide help and get respect from community
  As an authenticated user
  I want to be able to propose answer for question
} do

  given(:user) {create :user}
  given(:question) {create :question}
  given(:answer) {build :answer}

  describe 'Authenticated user' do
    before {sign_in user}
    
    scenario 'Creates answer', js: true do
      visit question_path(question)
      fill_in 'Your answer', with: answer.body
      click_on 'Post your answer'
      expect(page).to have_content 'Your answer has successfully been added!'
      expect(page).to have_content answer.body
    end

    scenario 'Tries to create answer with short body and no luck', js: true do
      visit question_path(question)
      fill_in 'Your answer', with: 'shrtbdy'
      click_on 'Post your answer'

      expect(page).to have_content 'Body is too short'
      visit question_path(question)
      expect(page).not_to have_content 'shrtbdy'
    end

  end

  describe 'Unauthenticated user' do
    scenario 'Tries to create answer with no luck' do
      visit question_path(question)
      expect(page).not_to have_selector("input[type=submit][value='Post your answer']")
    end
    scenario 'Can see list of answers' do
      answers = create_list(:answer, 5, question: question)
      visit question_path(question)
      answers.each{|answer| expect(page).to have_content answer.body}
    end
  end
end