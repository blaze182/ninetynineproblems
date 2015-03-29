class AnswersController < ApplicationController
  before_action :load_question, only: [:new, :create, :update, :destroy]
  before_action :load_answer, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  # def edit
  # end

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      flash[:notice] = 'Your answer has successfully been added!'
    else
      flash[:alert] = @answer.errors.empty? ? "Error" : @answer.errors.full_messages.to_sentence
    end
    redirect_to @question # целесообразнее вернуться на страницу вопроса
  end
  
  def update
    if @answer.user == current_user
      if @answer.update answer_params
        flash[:notice] = 'Your changes have been successfully saved!'
        redirect_to @question
      else
        flash[:alert] = @answer.errors.empty? ? "Error" : @answer.errors.full_messages.to_sentence
        render :edit
      end
    else
      flash[:alert] = 'Access denied'
      redirect_to @question
    end
  end

  def destroy
    if @answer.user == current_user
      if @answer.destroy!
        flash[:notice] = 'Your answer has been successfully deleted!'
      end
    else
      flash[:alert] = 'Access denied'
    end
    redirect_to @question
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
