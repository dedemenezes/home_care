class AnswersController < ApplicationController
  def create
    @round              = Round.find(params[:round_id])
    @option             = Option.find(params[:answer][:user_answer_id])
    @question           = @option.question
    @answer             = Answer.new
    @answer.round       = @round
    @answer.user_answer = @option
    @answer.question    = @question
    authorize @answer
    if @answer.save
      if @option.right?
        @answer.correct = true
        @answer.save
      else
        @answer.correct = false
        @answer.save
      end
      redirect_to round_path(@round, question: @question.id)
    else
      render 'rounds/show'
    end
  end
end
