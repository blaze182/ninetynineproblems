require 'rails_helper'

feature 'Destroy question', %q{
  In order to get rid of question for some reason
  As authenticated user
  I want to be able to delete my questions
} do
  
  scenario 'Unauthenticated user tries to destroy a question'
  scenario 'Authenticated user tries to destroy his question'
  scenario 'Authenticated user tries to destroy someone else\'s question'
end