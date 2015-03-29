require 'rails_helper'

feature 'Destroy question', %q{
  In order to get rid of question for some reason
  As authenticated user
  I want to be able to delete my questions
} do

  given(:user)              {create :user}
  given(:other_user)        {create :user}
  given(:question)          {create :question, user: user}
  given(:foreign_question)  {create :question, user: other_user}
  
  describe 'Authenticated user' do
    before {sign_in user}
    
    scenario 'Tries to destroy his question' do
      visit question_path(question)
      find('.question').click_on 'Delete'
      expect(page).to have_content 'Your question has been successfully deleted!'
      expect(page).not_to have_content question.title
    end

    scenario 'Tries to destroy someone else\'s question' do
      visit question_path(foreign_question)
      expect(find '.question').not_to have_content 'Delete'
    end
  end

  describe 'Unauthenticated user' do
    scenario 'Tries to destroy a question' do
      visit question_path(question)
      expect(find '.question').not_to have_content 'Delete'
    end
  end
  
end