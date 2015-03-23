require 'rails_helper'

feature 'Create answer', %q{
  In order to provide help and get respect from community
  As an authenticated user
  I want to be able to propose answer for question
} do

  scenario 'Authenticated user creates answer'
  scenario 'Unauthenticated user tries to create answer'
end