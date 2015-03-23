require 'rails_helper'

feature 'Edit answer body', %q{
  In order to correct mistakes in my answer, make it more accurate or relevant
  As an authenticated user
  I want to be able to edit my answer
} do

  scenario 'Unauthenticated user tries to edit answer'
  scenario 'Authenticated user tries to edit someone else\'s answer'
  scenario 'Authenticated user tries to edit his answer'
  
end