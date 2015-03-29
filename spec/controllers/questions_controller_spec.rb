require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create :user }
  let(:question) { create :question, user: user }
  let(:other_user) { create :user }
  let(:foreign_question) { create :question, user: other_user }

  describe 'GET #index' do
    let (:questions) { create_list :question, 2 }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns :questions).to match_array(questions)
    end

    it { should render_template :index }
  end

  describe 'GET #show' do
    before { get :show, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns :question).to eq question
    end

    it 'assigns a new answer to @answer' do
      expect(assigns :answer).to be_a_new(Answer)
    end

    it { should render_template :show }
  end

  describe 'GET #new' do
    sign_in_user

    before { get :new }

    it 'assigns a new question to @question' do
      expect(assigns :question).to be_a_new(Question)
    end

    it { should render_template :new }
  end

  describe 'GET #edit' do
    sign_in_user

    before { get :edit, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns :question).to eq question
    end

    it { should render_template :edit }
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      sign_in_user

      it 'saves the new question to database' do
        expect { post :create, question: attributes_for(:question) }.to change(@user.questions, :count).by(1)
      end

      it do
        post :create, question: attributes_for(:question)
        should redirect_to assigns :question
      end
    end

    context 'with invalid parameters' do
      sign_in_user

      it 'does not save the new question to database' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it do
        post :create, question: attributes_for(:invalid_question)
        should render_template :new
      end
    end

    context 'user signed out' do
      it do
        post :create, question: attributes_for(:question)
        should redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      sign_in_user

      it 'assigns the requested question to @question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns :question).to eq question
      end

      it 'alters question attributes' do
        new_title = 'Some new title, longer than 15 chars'
        new_body = 'This body actually should be longer than 30 characters'

        patch :update, id: question, question: { title: new_title, body: new_body }
        question.reload
        expect(question.title).to eq new_title
        expect(question.body).to eq new_body
      end

      it 'does not alter a foreign question' do
        new_title = 'Some new title, longer than 15 chars'
        new_body = 'This body actually should be longer than 30 characters'

        patch :update, id: foreign_question, question: { title: new_title, body: new_body }
        foreign_question.reload
        expect(foreign_question.title).not_to eq new_title
        expect(foreign_question.body).not_to eq new_body
      end

      it do
        patch :update, id: question, question: attributes_for(:question)
        should redirect_to question
      end
    end

    context 'with invalid parameters' do
      sign_in_user

      before { patch :update, id: question, question: {title: 'Sample title longer than 15 characters', body: nil} }

      it 'does not save answer attributes to database' do
        question.reload
        expect(question.title).not_to eq 'Sample title longer than 15 characters'
        expect(question.body).not_to eq nil
      end

      it { should render_template :edit }
    end

    context 'user signed out' do
      it do
        patch :update, id: question, question: attributes_for(:question)
        should redirect_to new_user_session_path
      end
    end

  end

  describe 'DELETE #destroy' do

    context 'user signed in' do
      sign_in_user

      before { question }

      it 'deletes question' do
        expect {delete :destroy, id: question}.to change(Question, :count).by(-1)
      end

      it 'does not delete a foreign question' do
        foreign_question
        expect {delete :destroy, id: foreign_question}.not_to change(Question, :count)
      end

      it do
        delete :destroy, id: question
        should redirect_to questions_path
      end
    end

    context 'user signed out' do
      before { question }

      it do
        delete :destroy, id: question
        should redirect_to new_user_session_path
      end
    end

  end
end
