class ConsultationsController < ApplicationController
  def create
    @patient = current_user
    @doctor = User.find(params[:user_id])
    @consultation = Consultation.new(consultation_params)
    @consultation.starting_at = @consultation.starting_at.beginning_of_hour
    @consultation.price = 100
    @consultation.patient = @patient
    @consultation.doctor = @doctor
    @consultation.location = @patient.country
    authorize @consultation
    if @consultation.save
      redirect_to profile_path
    else
      render 'doctors/show'
    end
  end

  private

  def consultation_params
    params.require(:consultation).permit(:starting_at)
  end
end
