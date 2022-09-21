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

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "doctors/show", locals: {doctor: @doctor, marker: @marker}, formats: [:html] }
    end
  end
end
