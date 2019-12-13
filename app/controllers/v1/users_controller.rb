# frozen_string_literal: true

class V1::UsersController < ApplicationController
  before_action :pundit_user, except: [:create]

  def create
    user = User.new(user_params)

    if user.save
      token = JsonWebToken.encode(id: user.id)
      render :user, locals: { user: user, token: token }, status: 201
    else
      render json: { message: 'Cannot create account', errors: user.errors }, status: 422
    end
  end

  def update
    user = find_user
    return unless user

    authorize user
    if user.update(user_params)
      render :user, locals: { user: user, token: nil }, status: 202
    else
      process_error(user, 'Cannot update user')
    end
  end

  def destroy
    user = find_user
    return unless user

    if user.destroy
      action_success('Account deleted', 202)
    else
      process_error(user, 'Something went wrong')
    end
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

  def find_user
    user = User.find_by(id: params[:id])
    return user if user

    render json: { error: 'Cannot find user' }
    nil
  end
end
