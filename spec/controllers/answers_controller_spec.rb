require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let (:user) { create :user }
  let (:question_with_answers) { create :question_with_answers, user: user }
  let (:question) { create :question, user: user }
  let (:answer) { create :answer, question: question, user: user }
  let (:other_user) { create :user }
  let (:foreign_answer) { create :answer, question: question, user: other_user }

  describe 'GET #edit' do
    sign_in_user

    before { get :edit, question_id: question_with_answers, id: question_with_answers.answers[0] }

    it 'assigns the requested answer to @answer' do
      expect(assigns :answer).to eq question_with_answers.answers[0]
    end

    it { should render_template :edit }
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      sign_in_user

      it 'saves the new answer assigned to question to database' do
        expect { post :create, question_id: question, answer: attributes_for(:answer), format: :js }
                                                      .to change(question.answers, :count).by(1)
      end

      it 'saves the new answer assigned to user to database' do
        expect { post :create, question_id: question, answer: attributes_for(:answer), format: :js }
                                                      .to change(@user.answers, :count).by(1)
      end

      it do
        post :create, question_id: question, answer: attributes_for(:answer), format: :js
        should render_template :create
      end
    end

    context 'with invalid parameters' do
      sign_in_user

      it 'does not save the new answer to database' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js }
                                                      .to_not change(question.answers, :count)
      end

      it do
        post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js
        should render_template :create
      end
    end

    context 'user signed out' do
      it do
        post :create, question_id: question, answer: attributes_for(:answer)
        should redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      sign_in_user

      it 'assigns answer to @answer' do
        patch :update, question_id: question, id: answer, answer: attributes_for(:answer), format: :js
        expect(assigns :answer).to eq answer
      end

      it 'assigns question to @question' do
        patch :update, question_id: question, id: answer, answer: attributes_for(:answer), format: :js
        expect(assigns :question).to eq question
      end

      it 'alters answer attributes' do
        new_body = 'This body actually should be longer than 30 characters'

        patch :update, question_id: question, id: answer, answer: {body: new_body}, format: :js
        answer.reload
        expect(answer.body).to eq new_body
      end

      it 'does not alter foreign answer' do
        new_body = 'This body actually should be longer than 30 characters'

        patch :update, question_id: question, id: foreign_answer, answer: {body: new_body}, format: :js
        foreign_answer.reload
        expect(foreign_answer.body).not_to eq new_body
      end

      it do
        patch :update, question_id: question, id: answer, answer: attributes_for(:answer), format: :js
        should render_template :update
      end
    end

    context 'with invalid parameters' do
      sign_in_user

      before do
        patch :update, question_id: question, id: answer, answer: {body: 'short'}, format: :js
      end

      it 'does not save answer attributes to database' do
        answer.reload
        expect(answer.body).not_to eq 'short'
      end

      it { should render_template :update }
    end

    context 'user signed out' do
      it do
        patch :update, question_id: question_with_answers, id: question_with_answers.answers[0], answer: attributes_for(:answer)
        should redirect_to new_user_session_path
      end
    end

  end

  describe 'PATCH #mark_best' do
    context 'user is signed in and owns question' do
      sign_in_user

      before { patch :mark_best, question_id: question, id: answer, format: :js }

      it 'assigns answer to @answer' do
        expect(assigns :answer).to eq answer
      end

      it 'assigns question to @question' do
        expect(assigns :question).to eq question
      end

      it 'marks answer as the best' do
        answer.reload
        expect(answer).to be_best
      end

      it { should render_template :mark_best }
    end

    context 'user signed in and does not own a question' do
      let(:foreign_question) { create :question, user: other_user}
      let(:more_answers) { create_list :answer, 5, question: foreign_question }

      sign_in_user

      it 'does not mark foreign answer as the best' do
        patch :mark_best, question_id: foreign_question, id: more_answers[3], format: :js
        more_answers[3].reload
        expect(more_answers[3]).not_to be_best
      end
    end

    context 'user signed out' do
      it do
        patch :mark_best, question_id: question, id: answer, format: :js
        should respond_with 401
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'user signed in' do
      sign_in_user

      before { answer }

      it 'deletes answer' do
        expect {delete :destroy, question_id: question, id: answer, format: :js}.to change(Answer, :count).by(-1)
      end

      it 'does not delete foreign answer' do
        foreign_answer
        expect {delete :destroy, question_id: question, id: foreign_answer, format: :js}.not_to change(Answer, :count)
      end

      it do
        delete :destroy, question_id: question, id: answer, format: :js
        should render_template :destroy
      end
    end

    context 'user signed out' do
      it do
        delete :destroy, question_id: question_with_answers, id: question_with_answers.answers[0]
        should redirect_to new_user_session_path
      end
    end
  end
end
