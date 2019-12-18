class V1::AccountActivationsController < ApplicationController
  def activate
    user = User.find_by(email: params[:email])
    if user &.email_authenticated?(:activation,params[:id])
      user.activate
      render json: { message: 'Account activated. You may now log in.'}, status: 200
    else
      render json: { error: 'Invalid activation link' }
    end
  end
end
