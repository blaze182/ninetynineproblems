require 'rails_helper'

feature 'Destroy question or answer', %q{
  In order to get rid of answer or question for some reason
  As authenticated user
  I want to be able to delete my answers or questions
} do
  
  scenario 'Unauthenticated user tries to destroy a question'
  scenario 'Unauthenticated user tries to destroy an answer'
  scenario 'Authenticated user tries to destroy his question'
  scenario 'Authenticated user tries to destroy his answer'
  scenario 'Authenticated user tries to destroy someone else\'s question'
  scenario 'Authenticated user tries to destroy someone else\'s answer'
end