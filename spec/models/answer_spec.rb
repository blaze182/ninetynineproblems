require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) { create :question }
  let(:answer) { create :answer, question: question }
  let!(:answers) { create_list :answer, 5, question: question, best: true }

  it { should belong_to :question }
  it { should validate_presence_of :body }
  it { should validate_length_of(:body).is_at_least(30).is_at_most(30000) }
  it { should belong_to :user }

  describe 'mark answer as the best' do
    before { answer.mark_best }

    it 'makes answer the best' do
      answer.reload
      expect(answer).to be_best
    end

    it 'makes the rest of answers not best' do
      answers.each do |a|
        a.reload
        expect(a).not_to be_best
      end
    end
  end

  describe 'default scope' do
    it 'shows the best answer on top' do
      answers[3].mark_best
      question.answers.reload
      expect(question.answers.first).to eq answers[3]
    end
  end
end
