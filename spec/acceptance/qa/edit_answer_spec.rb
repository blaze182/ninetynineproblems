require_relative '../acceptance_helper'

feature 'Answer editing', %q{
  In order to correct mistakes in my answer, make it more accurate or relevant
  As an answer author
  I want to be able to edit my answer
} do
  given(:user)            {create :user}
  given(:other_user)      {create :user}
  given!(:question)       {create :question}
  given!(:answer)         {create :answer, question: question, user: user}
  given!(:foreign_answer) {create :answer, question: question, user: other_user}

  describe 'Authenticated user' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'Alters his answer', js: true do
      find("#answer_#{answer.id}").click_on 'Edit'
      fill_in 'Edit your answer', with: 'New answer containing more than 30 symbols'
      click_on 'Save answer'

      expect(page).to have_content 'Your changes have been successfully saved!'
      expect(page).to have_content 'New answer containing more than 30 symbols'
      expect(page).not_to have_content answer.body
      expect(find("#answers")).not_to have_selector 'textarea'
    end

    scenario 'Tries to edit answer with short body and no luck', js: true do
      find("#answer_#{answer.id}").click_on 'Edit'
      fill_in 'Edit your answer', with: 'shrtbdy'
      click_on 'Save answer'

      expect(page).to have_content 'Body is too short'
      visit question_path(question)
      expect(page).not_to have_content 'shrtbdy'
    end

    scenario 'Tries to edit someone else\'s answer with no luck' do
      expect(find("#answer_#{foreign_answer.id}")).not_to have_content 'Edit'
    end

  end

  describe 'Unauthenticated user' do
    scenario 'Tries to edit answer with no luck' do
      visit question_path(question)
      expect(find("#answer_#{answer.id}")).not_to have_content 'Edit'
    end
  end
  
end