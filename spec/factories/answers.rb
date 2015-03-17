FactoryGirl.define do
  factory :answer do
    body "MyText"
    question 1
  end
  
  factory :invalid_answer, class: 'Answer' do
    body nil
    question nil
  end

end
