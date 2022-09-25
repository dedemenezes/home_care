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
      @answer.correct! if @option.right?
      if @round.last_question? @question
        redirect_to score_round_path(@round)
      else
        @next_question = [@round.questions, @round.answered_questions].flatten.uniq.sample
        redirect_to round_path(@round, question: @next_question.id)
      end
    else
      render 'rounds/show'
    end
  end
end
