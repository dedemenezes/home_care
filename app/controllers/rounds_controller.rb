class RoundsController < ApplicationController
  def show
    @round = Round.find(params[:id])
    # eliminar questoes respondidas no round vencedor

    if params[:question].present?
      next_question = params[:question].to_i + 1
      @question = Question.find(next_question) if next_question
    else
      @question = Question.where(level: @round.level).first
    end

    @answer = Answer.new
    authorize @round
  end

  def create
    @game = Game.find(params[:game_id])
    @round = Round.new
    completed_rounds = current_user.rounds.where(game: @game, completed: true)
    if completed_rounds.empty?
      @round.level = 1
    else
      @round.level = completed_rounds.order(level: :desc).first.level
    end
    @round.user = current_user
    @round.game = @game
    authorize @round
    if @round.save
      redirect_to round_path(@round)
    else
      render 'games/index', status: :unprocessable_entity
    end
  end

  def score
    @round = Round.find(params[:id])
    if @round.answers.count(&:correct) == 5 && !@round.completed?
      @round.completed!
    end
    if @round.completed? && @round.points_not_given?
      # won't work because the game can be referenced in many differnet users
      # a game can have many users and a user will have many games
      # need to create a join table
      # @round.game.update(level: @round.game.level += 1)
      current_user.update(points: current_user.points += 10)
      @round.update(points_given: true, level: @round.level += 1)
    end
    authorize @round
  end
end
