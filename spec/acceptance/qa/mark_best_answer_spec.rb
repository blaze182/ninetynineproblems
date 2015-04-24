require_relative '../acceptance_helper'

feature 'Mark answer as the best', %q{
  In order to emphasize one answer among others
  As a question author
  I want to be able to mark any answer as the best
} do

  given(:user) { create :user }
  given(:other_user) { create :user }
  given(:question) { create :question, user: user }
  given(:foreign_question) { create :question, user: other_user }
  given!(:answers) { create_list :answer, 5, question: question, user: user }
  given!(:more_answers) { create_list :answer, 5, question: foreign_question }

  describe 'Authenticated user' do
    before { sign_in user }

    scenario 'marks the best answer in his question', js: true do
      visit question_path(question)
      find("#answer_#{answers[3].id}").click_link 'Mark as best'
      
      expect(find "#answer_#{answers[3].id}").to have_content "Best answer!"
      expect(find "#answers div.answer:nth-child(1)").to eq find("#answer_#{answers[3].id}") # check order
      
      find("#answer_#{answers[1].id}").click_on 'Mark as best' # 2nd attempt
      
      expect(find "#answer_#{answers[1].id}").to have_content "Best answer!"
      expect(find "#answers div.answer:nth-child(1)").to eq find("#answer_#{answers[1].id}") # check order

    end

    scenario 'tries to mark the best answer in foreign question with no luck' do
      visit question_path(foreign_question)
      expect(page).not_to have_content "Mark as best"
    end
  end

  describe 'Unauthenticated user' do
    scenario 'tries to mark the best answer in foreign question with no luck' do
      visit question_path(question)
      expect(page).not_to have_content "Mark as best"
    end
  end
end
