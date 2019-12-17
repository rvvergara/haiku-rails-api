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

    authorize booking, :confirm?
    if booking.confirm
      render :booking, locals: { booking: booking }, status: 202
    else
      process_error(booking, 'Cannot confirm booking. Booking may have already been confirmed.')
    end
  end



  private

  def find_booking
    booking = Booking.find_by(id: params[:id])
    return booking if booking

    find_error('booking')
  end
end
