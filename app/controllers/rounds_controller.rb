class RoundsController < ApplicationController
  def show
    @round = Round.find(params[:id])
    # eliminar questoes respondidas no round vencedor
    @question = Question.where(level: @round.level, game: @round.game).first
    @question = Question.find(params[:question]) if params[:question].present?
    @answer = Answer.new
    authorize @round
  end

  def create
    @game = Game.find(params[:game_id])
    @round = Round.new
    @round.user = current_user
    @round.game = @game
    @round.set_level
    authorize @round
    if @round.save
      redirect_to round_path(@round)
    else
      render 'games/index', status: :unprocessable_entity
    end
  end

  def score
    @round = Round.find(params[:id])
    FinishRound.new(@round).complete.give_points_for(current_user)
    authorize @round
  end
end
