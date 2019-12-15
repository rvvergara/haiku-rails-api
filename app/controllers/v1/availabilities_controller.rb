# frozen_string_literal: true

class V1::AvailabilitiesController < ApplicationController
  before_action :pundit_user

  def index
    practitioner = find_practitioner
    return unless practitioner

    render json: { availabilities: practitioner.availabilities }, status: 200
  end

  def show
    availability = find_availability
    return unless availability

    render json: { availability: availability }, status: 200
  end

  def create
    practitioner = find_practitioner
    return unless practitioner

    availability = practitioner.availabilities.build(availability_params)

    authorize availability
    if availability.save
      render json: { availability: availability }, status: 201
    else
      render json: { message: 'Cannot create availability', errors: availability.errors }
    end
  end

  def update
    availability = find_availability
    return unless availability

    authorize availability
    if availability.update(availability_params)
      render json: { availability: availability }, status: 202
    else
      process_error(availability, 'Cannot update availability')
    end
  end

  def destroy
    availability = find_availability
    return unless availability

    authorize availability
    if availability.destroy
      action_success('Availability slot deleted', 202)
    else
      process_error(availability, 'Something went wrong')
    end
  end

  private

  def availability_params
    params
      .require(:availability)
      .permit(
        :availability_date,
        :start_time,
        :end_time,
        :booked
      )
  end

  def find_availability
    availability = Availability.find_by(id: params[:id])
    return availability if availability

    find_error('availability')
    nil
  end

  def find_practitioner
    practitioner = Practitioner.find_by(id: params[:practitioner_id])
    return practitioner if practitioner

    find_error('practitioner')
    nil
  end
end
