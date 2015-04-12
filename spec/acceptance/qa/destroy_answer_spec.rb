require_relative '../acceptance_helper'

feature 'Destroy answer', %q{
  In order to get rid of answer for some reason
  As authenticated user
  I want to be able to delete my answers
} do
  
  given(:user)            {create :user}
  given(:other_user)      {create :user}
  given!(:question)       {create :question}
  given!(:answer)         {create :answer, question: question, user: user}
  given!(:foreign_answer) {create :answer, question: question, user: other_user}

  describe 'Authenticated user' do
    before {sign_in user}
    scenario 'Tries to destroy his answer' do
      visit question_path(question)
      find("#answer_#{answer.id}").click_on 'Delete'
      expect(page).to have_content 'Your answer has been successfully deleted!'
      expect(page).not_to have_content answer.body
    end

    scenario 'Tries to destroy someone else\'s answer with no luck' do
      visit question_path(question)
      expect(find("#answer_#{foreign_answer.id}")).not_to have_content 'Delete'
    end
  end

  describe 'Unauthenticated user' do
    scenario 'Tries to destroy an answer with no luck' do
      visit question_path(question)
      expect(find("#answer_#{answer.id}")).not_to have_content 'Delete'
    end
  end

end