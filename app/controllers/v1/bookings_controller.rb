class V1::BookingsController < ApplicationController
  before_action :pundit_user

  def show
  end

  def create
    patient = find_patient
    return unless patient

    booking = patient.bookings.build(booking_params)

    authorize booking
    if booking.save_record
      render :create, locals: { booking: booking }, status: 201
    else
      process_error(booking, 'Cannot create booking')
    end
  end

  def update
  end

  private

  def booking_params
    params
      .require(:booking)
      .permit(
        :appointment_date,
        :start_time,
        :practitioner_id,
        :consumed,
        :expired,
        :cancelled,
        :rejected
      )
  end

  def find_booking
    booking = Booking.find_by(id: params[:id])
    return booking if booking

    find_error('booking')
  end

  def find_patient
    patient = Patient.find_by(id: params[:patient_id])
    return patient if patient

    find_error('patient')
  end
end
