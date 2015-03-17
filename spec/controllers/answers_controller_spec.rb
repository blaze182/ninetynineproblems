require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let (:question_with_answers) { create :question_with_answers }
  let (:question) { create :question }

  describe 'GET #index' do
    before { get :index, question_id: question_with_answers }

    it 'assigns question to @question' do
      expect(assigns :question).to eq question_with_answers
    end

    it 'populates an array of all answers for question' do
      expect(assigns :answers).to match_array(question_with_answers.answers)
    end

    it { should render_template :index }
  end

  describe 'GET #new' do
    before { get :new, question_id: question_with_answers }

    it 'assigns question to @question' do
      expect(assigns :question).to eq question_with_answers
    end

    it 'assigns a new answer to @answer' do
      expect(assigns :answer).to be_a_new(Answer)
    end

    it { should render_template :new }
  end

  describe 'GET #edit' do
    before { get :edit, question_id: question_with_answers, id: question_with_answers.answers[0] }

    it 'assigns the requested answer to @answer' do
      expect(assigns :answer).to eq question_with_answers.answers[0]
    end

    it { should render_template :edit }
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'saves the new answer to database' do
        expect { post :create, question_id: question, answer: attributes_for(:answer) }
                                                      .to change(question.answers, :count).by(1)
      end

      it do
        post :create, question_id: question, answer: attributes_for(:answer)
        should redirect_to assigns :question
      end
    end

    context 'with invalid parameters' do
      it 'does not save the new answer to database' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer) }
                                                      .to_not change(question.answers, :count)
      end

      it do
        post :create, question_id: question, answer: attributes_for(:invalid_answer)
        should render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'assigns answer to @answer' do
        patch :update, question_id: question_with_answers, id: question_with_answers.answers[0], answer: attributes_for(:answer)
        expect(assigns :answer).to eq question_with_answers.answers[0]
      end

      it 'alters answer attributes' do
        new_body = 'This body actually should be longer than 30 characters'

        patch :update, question_id: question_with_answers, id: question_with_answers.answers[0], answer: {body: new_body}
        question_with_answers.reload
        expect(question_with_answers.answers[0].body).to eq new_body
      end

      it do
        patch :update, question_id: question_with_answers, id: question_with_answers.answers[0], answer: attributes_for(:answer)
        should redirect_to question_with_answers
      end
    end

    context 'with invalid parameters' do
      before do
        patch :update, question_id: question_with_answers, id: question_with_answers.answers[0], answer: {body: nil}
      end

      it 'does not save answer attributes to database' do
        question_with_answers.reload
        expect(question_with_answers.answers[0].body).to eq 'MyText that is longer, than 30 characters. Because answer should be'
      end

      it { should render_template :edit }
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes answer' do
      expect {delete :destroy, question_id: question_with_answers, id: question_with_answers.answers[0]}.to change(question_with_answers.answers, :count).by(-1)
    end

    it do
      delete :destroy, question_id: question_with_answers, id: question_with_answers.answers[0]
      should redirect_to assigns :question
    end
  end
end
