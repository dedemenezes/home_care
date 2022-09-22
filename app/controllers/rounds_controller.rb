class RoundsController < ApplicationController
  def show
    @round = Round.find(params[:id])
    @question = Question.first unless params[:question].present?
    next_question = params[:question].to_i + 1 if params[:question].present?
    @question = Question.find(next_question) if next_question
    @answer = Answer.find_by(question: @question, round: @round) || Answer.new
    authorize @round
  end

  def create
    @game = Game.find(params[:game_id])
    @round = Round.new
    @round.user = current_user
    @round.game = @game
    authorize @round
    if @round.save
      redirect_to round_path(@round)
    else
      render 'games/index', status: :unprocessable_entity
    end
  end
end
