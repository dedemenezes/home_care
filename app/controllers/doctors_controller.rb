class DoctorsController < ApplicationController
  def index
    @doctors = policy_scope(User).where(role: 'doctor')
  end

  def show
    @doctor = User.find(params[:id])
    authorize @doctor
  end
end
