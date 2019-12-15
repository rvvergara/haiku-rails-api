class V1::Patients::BookingsController < ApplicationController
  before_action :pundit_user

  def index
    patient = find_patient
    return unless patient
    bookings = patient.bookings
    render :bookings, locals: { bookings: bookings }, status: 200
  end

  private

  def find_patient
    patient = Patient.find_by(id: params[:patient_id])
    return patient if patient
    find_error('patient')
    nil
  end
end
