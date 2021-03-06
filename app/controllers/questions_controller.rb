class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  after_action  :discard_flash_messages, only: [:update]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
  end

  # def edit
  # end

  def update # js enabled
    if @question.user_id == current_user.try(:id)
      if @question.update question_params
        flash[:notice] = 'Your changes have been successfully saved!'
      end
    else
      flash[:alert] = 'Access denied'
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      flash[:notice] = 'Your question has successfully been created!'
      redirect_to @question
    else
      flash[:alert] = @question.errors.empty? ? "Error" : @question.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    if @question.user_id == current_user.try(:id)
      if @question.destroy!
        flash[:notice] = 'Your question has been successfully deleted!'
      end
    else
      flash[:alert] = 'Access denied'
    end
    redirect_to questions_path
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
