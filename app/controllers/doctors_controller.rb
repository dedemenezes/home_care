class DoctorsController < ApplicationController
  def index
    @doctors = policy_scope(User).where(role: 'doctor')
  end

  def show
    @doctor = User.find(params[:id])
    @marker = {
      lat: @doctor.latitude,
      lng: @doctor.longitude
    }
    @consultation = Consultation.new
    authorize @doctor

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "profiles/header", locals: {user: @doctor}, formats: [:html] }
    end
  end
end
