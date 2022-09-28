class RoundsController < ApplicationController
  def show
    @round = Round.find(params[:id])
    # eliminar questoes respondidas no round vencedor
    @question = Question.where(level: @round.level).first
    @question = Question.find(params[:question]) if params[:question].present?
    @answer = Answer.new
    binding.pry
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
    binding.pry
    if @round.correct_answers_count == 5 && !@round.completed?
      @round.completed!
    end
    if @round.completed? && @round.points_not_given?
      # won't work because the game can be referenced in many differnet users
      # a game can have many users and a user will have many games
      # need to create a join table
      # @round.game.update(level: @round.game.level += 1)
      current_user.update(points: current_user.points += 10)
      @round.update(points_given: true)
    end
    authorize @round
  end
end
