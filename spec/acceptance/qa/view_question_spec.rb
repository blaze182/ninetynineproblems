require 'rails_helper'

feature 'View question with answers', %q{
  In order to find answers to a question
  As a guest or an authenticated user
  I want to be able to view question with it's answers
} do

  scenario 'Authenticated user views question with answers'
  scenario 'Unauthenticated user views question with answers'
end