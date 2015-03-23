require 'rails_helper'

feature 'User sign up', %q{
  In order to be able to sign in to ask a question
  As unregistered user
  I want to be able to sign up
} do

  scenario 'Authenticated user tries to sign up'
  scenario 'Unregistered user tries to sign up with existing identity'
  scenario 'Unregistered user signs up'

end