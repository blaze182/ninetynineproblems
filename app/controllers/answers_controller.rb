class AnswersController < ApplicationController
  before_action :load_question, only: [:new, :create, :update, :destroy, :mark_best]
  before_action :load_answer, only: [:edit, :update, :destroy, :mark_best]
  before_action :authenticate_user!
  after_action  :discard_flash_messages, only: [:create, :destroy, :update]

  # def edit
  # end

  def create # js enabled
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    flash[:notice] = 'Your answer has successfully been added!' if @answer.save
  end

  def update # js enabled
    if @answer.user_id == current_user.try(:id)
      if @answer.update answer_params
        flash[:notice] = 'Your changes have been successfully saved!'
      end
    else
      flash[:alert] = 'Access denied'
    end
  end

  def mark_best # js enabled
    @answer.mark_best if @question.user_id == current_user.try(:id)
  end

  def destroy # js enabled
    if @answer.user_id == current_user.try(:id)
      @answer.destroy!
    else
      flash[:alert] = 'Access denied'
    end
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
