FactoryGirl.define do
  sequence :body do |n|
    "MyText that is longer, than 30 characters. Because answer should be. No.#{n}"
  end
  factory :answer do
    body 
    question
  end

  factory :invalid_answer, class: 'Answer' do
    body 'Short'
    question
  end

end
