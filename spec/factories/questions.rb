FactoryGirl.define do
  sequence :title do |n|
    "The title is minimum of 15 characters No.#{n}"
  end

  factory :question do
    title
    body "MyText is definitely should be more than 30 characters"
    user

    factory :question_with_answers do
      transient do
        answers_count 5
      end

      after(:create) do |question, evaluator|
        create_list(:answer, evaluator.answers_count, question: question)
      end
    end

  end

  factory :invalid_question, class: 'Question' do
    title "Invalid title"
    body nil
    user
  end

end
