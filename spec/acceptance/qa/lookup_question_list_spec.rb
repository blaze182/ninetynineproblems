require 'rails_helper'

feature 'Lookup question list', %q{
  In order to find interesting answers to interesting questions
  As a guest or an authenticated user
  I want to be able to lookup through question list
} do

  scenario 'Authenticated user reads question list'
  scenario 'Unauthenticated user reads question list'
end