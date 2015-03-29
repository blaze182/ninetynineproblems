require 'rails_helper'

feature 'Lookup question list', %q{
  In order to find interesting answers to interesting questions
  As any user
  I want to be able to lookup through question list
} do

  given!(:question_list) {create_list :question, 5}

  scenario 'User reads question list' do
    visit questions_path
    question_list.each do |question|
      expect(page).to have_content question.title
    end
  end

end
