require 'rails_helper'

feature 'Edit question body and text', %q{
  In order to correct mistakes in my question or make it more accurate
  As an authenticated user
  I want to be able to edit my question
} do

  scenario 'Unauthenticated user tries to edit question'
  scenario 'Authenticated user tries to edit someone else\'s question'
  scenario 'Authenticated user tries to edit his question'
  
end