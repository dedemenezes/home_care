class GamesController < ApplicationController
  def index
    @games = policy_scope(Game)
    @round = Round.new
  end
end
