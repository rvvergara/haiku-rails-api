# frozen_string_literal: true

class V1::ClinicsController < ApplicationController
  before_action :pundit_user

  def index; end

  def show; end

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
    clinic = find_clinic
    return unless clinic

    authorize clinic
    if clinic.update(clinic_params)
      render :clinic, locals: { clinic: clinic }, status: 202
    else
      process_error(clinic, 'Cannot update clinic')
    end
  end

  def destroy
    clinic = find_clinic
    return unless clinic

    authorize clinic
    if clinic.destroy
      action_success('Clinic deleted')
    else
      process_error(clinic, 'Cannot delete clinic')
    end
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

  def find_clinic
    clinic = Clinic.find_by(id: params[:id])
    return clinic if clinic

    find_error('clinic')
    nil
  end
end
