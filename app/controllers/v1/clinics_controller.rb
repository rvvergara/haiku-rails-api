class V1::ClinicsController < ApplicationController
  before_action :pundit_user
  
  def index
  end

  def show
  end

  def create
    practitioner = find_practitioner
    return unless practitioner

    clinic = practitioner.created_clinics.build(clinic_params)

    authorize clinic
    if clinic.save
      render :clinic, locals: { clinic: clinic }, status: 201
    else
      process_error(clinic, 'Cannot create clinic')
    end
  end

  def update
  end

  def destroy
  end

  private

  def clinic_params
    params
      .require(:clinic)
      .permit(
        :avatar,
        :name,
        :address,
        :postal_code,
        :category,
        operating_hours: []
      )
  end

  def find_practitioner
    practitioner = Practitioner.find_by(id: params[:practitioner_id])
    return practitioner if practitioner

    find_error('practitioner')
    nil
  end
end
