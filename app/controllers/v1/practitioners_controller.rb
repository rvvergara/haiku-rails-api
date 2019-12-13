class V1::PractitionersController < ApplicationController
  before_action :pundit_user

  def index
  end

  def show
  end

  def create
    practitioner = Practitioner.new(practitioner_params)

    if practitioner.create_profile(pundit_user)
      render json: { profile: practitioner.attributes.merge(profile_pic: rails_blob_path(practitioner.profile_pic, only_path: true)) }, status: 201
    else
      render json: { message: 'Cannot create practitioner profile', errors: practitioner.errors }
    end
  end

  def update
  end

  def destroy
  end

  private

  def practitioner_params
    params
    .require(:practitioner).permit(
      :first_name,
      :last_name,
      :biography,
      :years_exp,
      :profile_pic,
      education: [],
      specializations: [],
    )
  end
end
