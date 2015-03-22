require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let (:question) { create :question }

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
    sign_in_user

    context 'with valid parameters' do
      it 'saves the new question to database' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it do
        post :create, question: attributes_for(:question)
        should redirect_to assigns :question
      end
    end

    context 'with invalid parameters' do
      it 'does not save the new question to database' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it do
        post :create, question: attributes_for(:invalid_question)
        should render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    context 'with valid parameters' do
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

      it do
        patch :update, id: question, question: attributes_for(:question)
        should redirect_to question
      end
    end

    context 'with invalid parameters' do
      before { patch :update, id: question, question: {title: 'Sample title longer than 15 characters', body: nil} }

      it 'does not save answer attributes to database' do
        question.reload
        expect(question.title).to eq "The title is minimum of 15 characters"
        expect(question.body).to eq "MyText is definitely should be more than 30 characters"
      end

      it { should render_template :edit }
    end

  end

  describe 'DELETE #destroy' do
    sign_in_user

    before { question }

    it 'deletes question' do
      expect {delete :destroy, id: question}.to change(Question, :count).by(-1)
    end

    it do
      delete :destroy, id: question
      should redirect_to questions_path
    end
  end
end
