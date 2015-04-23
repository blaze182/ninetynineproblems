require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should validate_presence_of :body }
  it { should validate_length_of(:body).is_at_least(30).is_at_most(30000) }
  it { should belong_to :user }

  describe 'mark answer as the best' do
    let(:question) { create :question }
    let(:answer) { create :answer, question: question }
    let!(:answers) { create_list :answer, 5, question: question, best: true }

    it 'makes answer the best' do
      answer.mark_best
      answer.reload
      expect(answer).to be_best
    end

    it 'makes the rest of answers not best' do
      answer.mark_best
      answers.each do |a|
        a.reload
        expect(a).not_to be_best
      end
    end
  end
end
