# frozen_string_literal: true

class V1::PatientsController < ApplicationController
  before_action :pundit_user
  def index; end

  def show
    patient = find_patient
    return unless patient

    render :patient, locals: {
      patient: patient
    }, status: 200
  end

  def create
    patient = Patient.new(patient_params)

    if patient.create_profile(pundit_user)
      render json: { profile: patient.attributes.merge(profile_pic: rails_blob_path(patient.profile_pic, only_path: true)) }, status: 201
    end
  end

  def update
    patient = find_patient
    return unless patient

    authorize patient
    if patient.update(patient_params)
      render :patient, locals: {
        patient: patient
      }, status: 202
    else
      process_error(patient, 'Cannot update patient profile')
    end
  end

  def destroy
    patient = find_patient
    return unless patient

    authorize patient
    if patient.destroy
      action_success('Patient profile deleted, you need to create a new one', 202)
    else
      process_error(patient, 'Something went wrong, cannot proceed.')
    end
  end

  private

  def find_patient
    patient = Patient.find_by(id: params[:id])
    return patient if patient

    find_error('patient')
    nil
  end

  def patient_params
    params.require(:patient)
      .permit(
        :first_name,
        :last_name,
        :nationality,
        :address,
        :postal_code,
        :birthday,
        :passport,
        :contact_number,
        :points,
        :profile_pic,
        languages: []
      )
  end
end
