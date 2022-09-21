class ProfilesController < ApplicationController
  def show
    authorize self
  end
end
