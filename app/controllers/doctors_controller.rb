class DoctorsController < ApplicationController
  def index
    @doctors = policy_scope(User).where(role: 'doctor').geocoded
  end

  def show
    @doctor = User.find(params[:id])
    @marker = {
      lat: @doctor.latitude,
      lng: @doctor.longitude
    }
    authorize @doctor
  end
end
