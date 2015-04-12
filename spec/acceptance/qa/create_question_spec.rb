require_relative '../acceptance_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask questions
} do
  
  given(:user)      {create :user}
  given(:question)  {create :question}

  describe 'Authenticated user' do
    before do
      sign_in user
      visit questions_path
      click_on 'Ask question'
    end

    scenario 'Creates question' do
      fill_in 'Title', with: question.title
      fill_in 'Body', with: question.body
      click_on 'Create'

      expect(page).to have_content 'Your question has successfully been created!'
      expect(page).to have_content question.title
    end

    scenario 'Tries to create question with short title and no luck' do
      fill_in 'Title', with: 'shortttl'
      fill_in 'Body', with: 'Test body is definitely longer than 30 symbols of text'
      click_on 'Create'

      expect(page).to have_content 'Title is too short'
      visit questions_path
      expect(page).not_to have_content 'shortttl'
    end

    scenario 'Tries to create question with short body and no luck' do
      fill_in 'Title', with: 'Test question longer than 15 symbols and having short body'
      fill_in 'Body', with: 'shrtbdy'
      click_on 'Create'

      expect(page).to have_content 'Body is too short'
      visit questions_path
      expect(page).not_to have_content 'Test question longer than 15 symbols and having short body'
    end
  end

  describe 'Unauthenticated user' do
    scenario 'Tries to create a question with no luck' do
      visit questions_path
      click_on 'Ask question'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
