class AnswersController < ApplicationController
  before_action :load_question, only: [:new, :create, :update, :destroy]
  before_action :load_answer, only: [:edit, :update, :destroy]

  def new
    @answer = Answer.new
  end

  # def edit
  # end

  def create
    @answer = @question.answers.build(answer_params)

    if @answer.save
      flash[:notice] = 'Your answer has successfully been added!'
      redirect_to @question # целесообразнее вернуться на страницу вопроса
    else
      render :new
    end
  end

  def update
    if @answer.update answer_params
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    if @answer.destroy!
      flash[:notice] = 'Your answer has been successfully deleted!'
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
