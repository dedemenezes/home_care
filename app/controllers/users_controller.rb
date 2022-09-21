class UsersController < ApplicationController
  def profile
    authorize current_user
  end
end
