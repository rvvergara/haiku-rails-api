class V1::PractitionersController < ApplicationController
  before_action :pundit_user

  def index
  end

  def show
    practitioner = find_practitioner
    return unless practitioner

    render :practitioner, locals: {practitioner: practitioner }, status: 200
  end

  def create
    practitioner = Practitioner.new(practitioner_params)

    authorize practitioner
    if practitioner.create_profile(pundit_user)
      render :practitioner, status: 201
    else
      process_error(practitioner, 'Cannot create practitioner profile')
    end
  end

  def update
  end

  def destroy
  end

  private

  def find_practitioner
    practitioner = Practitioner.find_by(id: params[:id])
    return practitioner if practitioner
    find_error('practitioner')
    nil
  end

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
