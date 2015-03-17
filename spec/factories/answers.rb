FactoryGirl.define do
  factory :answer do
    body "MyText that is longer, than 30 characters. Because answer should be"
    question
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    question nil
  end

end
