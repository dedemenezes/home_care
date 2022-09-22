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
      if @round.level_one_last_question_id == @question.id
        redirect_to games_path
      else
        redirect_to round_path(@round, question: @question.id)
      end
    else
      render 'rounds/show'
    end
  end
end
