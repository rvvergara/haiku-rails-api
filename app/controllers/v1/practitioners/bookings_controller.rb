class V1::Practitioners::BookingsController < ApplicationController
  before_action :pundit_user
  
  def index
    practitioner = find_practitioner
    return unless practitioner

    bookings = practitioner.bookings
    render :bookings, locals: { bookings: bookings }, status: 200
  end

  private

  def find_practitioner
    practitioner = Practitioner.find_by(id: params[:practitioner_id])
    return practitioner if practitioner

    find_error('practitioner')
    nil
  end
end
