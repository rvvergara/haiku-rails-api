class V1::PatientsController < ApplicationController
  before_action :pundit_user
  def index
  end

  def show
  end

  def create
    patient = Patient.new(patient_params)

    if patient.create_profile(pundit_user)
      render json: { profile: patient.attributes.merge(profile_pic: rails_blob_path(patient.profile_pic, only_path: true)) }, status: 201
    else
    end
  end

  def update
  end

  def destroy
  end

  private

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
