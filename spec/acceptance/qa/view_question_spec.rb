require 'rails_helper'

feature 'View question with answers', %q{
  In order to find answers to a question
  As a any user
  I want to be able to view question with it's answers
} do

  given(:user) {create :user}
  given!(:question_list) {create_list :question, 5}
  given!(:answers_list) {create_list :answer, 5, question: question_list[0]}

  scenario 'Any user views question with answers' do
    visit questions_path
    question_list.each do |question|
      expect(page).to have_content question.title
    end

    visit question_path(question_list[0])
    expect(page).to have_content question_list[0].title
    expect(page).to have_content question_list[0].body
    answers_list.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end
