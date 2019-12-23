# frozen_string_literal: true

class V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user &.valid_password?(params[:password])
      if user.activated?
        token = JsonWebToken.encode(id: user.id)
        render :create, locals: { user: user, token: token }, status: 200
      else
        render json: { message: 'You need to first confirm your email. Please check your email for confirmation link provided when you signed up.' }, status: 401
      end
    else
      render json: { error: 'Invalid Credentials' }, status: 401
    end
  end
end
