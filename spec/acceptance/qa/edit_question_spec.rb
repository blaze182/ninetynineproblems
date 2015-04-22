require_relative '../acceptance_helper'

feature 'Edit question body and text', %q{
  In order to correct mistakes in my question or make it more accurate
  As an authenticated user
  I want to be able to edit my question
} do

  given(:user)              {create :user}
  given(:other_user)        {create :user}
  given(:question)          {create :question, user: user}
  given(:foreign_question)  {create :question, user: other_user}
  
  describe 'Authenticated user' do
    before {sign_in user}

    scenario 'Alters his question', js: true do
      visit question_path(question)
      find('.question').click_on 'Edit'

      fill_in 'Title', with: 'New title for question longer than 15 symbols'
      fill_in 'Body', with: 'New body for question longer than 30 symbols'
      click_on 'Save question'

      expect(page).to have_content 'Your changes have been successfully saved!'
      expect(page).to have_content 'New title for question longer than 15 symbols'
      expect(page).to have_content 'New body for question longer than 30 symbols'
    end

    scenario 'Tries to edit question with short title and no luck', js: true do
      visit question_path(question)
      find('.question').click_on 'Edit'

      fill_in 'Title', with: 'shortttl'
      fill_in 'Body', with: 'Test body is definitely longer than 30 symbols of text'
      click_on 'Save question'

      expect(page).to have_content 'Title is too short'
      visit questions_path
      expect(page).not_to have_content 'shortttl'
    end

    scenario 'Tries to edit question with short body and no luck', js: true do
      visit question_path(question)
      find('.question').click_on 'Edit'

      fill_in 'Title', with: 'Test question longer than 15 symbols and having short body'
      fill_in 'Body', with: 'shrtbdy'
      click_on 'Save question'

      expect(page).to have_content 'Body is too short'
      visit questions_path
      expect(page).not_to have_content 'Test question longer than 15 symbols and having short body'
    end

    scenario 'Tries to edit someone else\'s question with no luck' do
      visit question_path(foreign_question)
      expect(find '.question').not_to have_content 'Edit'
    end
  end

  describe 'Unauthenticated user' do
    scenario 'Tries to edit question with no luck' do
      visit question_path(question)
      expect(find '.question').not_to have_content 'Edit'
    end
  end

end