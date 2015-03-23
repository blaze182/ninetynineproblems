require 'rails_helper'

feature 'User sign out', %q{
  In order to destroy my session
  As an Authenticated user
  I want to be able to sign out
} do

  scenario 'Authenticated user signs out'
  scenario 'Unauthenticated user tries to sign out'
end