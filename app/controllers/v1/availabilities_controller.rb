class V1::AvailabilitiesController < ApplicationController
  def index
  end

  def show
  end

  def create
    practitioner = Practitioner.find(params[:practitioner_id])
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
end
