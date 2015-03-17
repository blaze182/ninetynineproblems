FactoryGirl.define do
  factory :question do
    title "The title is minimum of 15 characters"
    body "MyText is definitely should be more than 30 characters"

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
  end

end
