require 'rails_helper'

feature 'Destroy answer', %q{
  In order to get rid of answer for some reason
  As authenticated user
  I want to be able to delete my answers
} do
  
  scenario 'Unauthenticated user tries to destroy an answer'
  scenario 'Authenticated user tries to destroy his answer'
  scenario 'Authenticated user tries to destroy someone else\'s answer'
end