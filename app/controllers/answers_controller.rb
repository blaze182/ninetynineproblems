class AnswersController < ApplicationController
  def index
    @answers = Answer.where(question_id: params[:question_id])
  end

  def show
  end

  def new
  end

  def edit
  end
end
