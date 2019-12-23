# frozen_string_literal: true

class V1::BookingsController < ApplicationController
  before_action :pundit_user

  def index
    bookings = pundit_user.bookings

    render :bookings, locals: { bookings: bookings }, status: 200
  end

  def show
    booking = find_booking
    return unless booking

    render :booking, locals: { booking: booking }, status: 200
  end

  # Custom action names for bookings
  # 1. Practitioner confirming
  def confirm
    booking = find_booking
    return unless booking

    authorize booking, :practitioner_booking_response?
    if booking.confirm(booking_params)
      render :booking, locals: { booking: booking }, status: 202
    else
      process_error(booking, 'Cannot confirm booking. Booking may have already been confirmed.')
    end
  end

  # 2. Practitioner rejecting a booking
  def reject
    booking = find_booking
    return unless booking

    authorize booking, :practitioner_booking_response?
    if booking.reject(booking_params)
      render :booking, locals: { booking: booking }, status: 202
    else
      process_error(booking, 'Cannot reject booking. Booking may have already been rejected or cancelled.')
    end
  end

  # 3. Patient cancelling a booking
  def cancel
    booking = find_booking
    return unless booking

    authorize booking, :patient_booking_response?
    if booking.cancel(booking_params)
      render :booking, locals: { booking: booking }, status: 202
    else
      process_error(booking, 'Cannot cancel booking. Booking may have already been rejected or cancelled.')
    end
  end

  private

  def booking_params
    params
      .require(:booking)
      .permit(
        :practitioner_remarks,
        :patient_remarks
      )
  end

  def find_booking
    booking = Booking.find_by(id: params[:id])
    return booking if booking

    find_error('booking')
    nil
  end
end
