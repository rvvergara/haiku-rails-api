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

  private

  def find_booking
    booking = Booking.find_by(id: params[:id])
    return booking if booking

    find_error('booking')
  end
end
