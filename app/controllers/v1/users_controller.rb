class V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      token = JsonWebToken.encode({ id: user.id })
      render :create, locals: { user: user, token: token }, status: 201
    else
      render json: { message: 'Cannot create account', errors: user.errors }, status: 422
    end
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :role
    )
  end
end
