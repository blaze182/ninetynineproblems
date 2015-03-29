require 'rails_helper'

feature 'View question with answers', %q{
  In order to find answers to a question
  As any user
  I want to be able to view question with it's answers
} do

  given!(:question) {create :question}
  given!(:answers_list) {create_list :answer, 5, question: question}

  scenario 'Any user views question with answers' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers_list.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end
