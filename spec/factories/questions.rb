FactoryGirl.define do
  factory :question do
    title "The title is minimum of 15 characters"
    body "MyText is definitely should be more than 30 characters"
  end

  factory :invalid_question, class: 'Question' do
    title "Invalid title"
    body nil
  end

end
