class V1::Practitioners::BookingsController < V1::BookingsController
  before_action :pundit_user

  def create
    practitioner = find_practitioner
    return unless practitioner

    booking = practitioner.bookings.build(booking_params)

    
    if booking.save_record
      render json: { booking: booking }, status: 201
    else
      process_error(booking, 'Cannot create booking')
    end
  end

  private

  def find_practitioner
    practitioner = Practitioner.find_by(id: params[:practitioner_id])
    return practitioner if practitioner

    find_error('practitioner')
    nil
  end

  def booking_params
    params
      .require(:booking)
      .permit(
        :appointment_date,
        :start_time,
        :patient_id,
        :consumed,
        :expired,
        :cancelled,
        :rejected
      )
  end
end
