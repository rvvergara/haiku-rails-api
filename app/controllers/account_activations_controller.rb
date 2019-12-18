class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    debugger
    if user &.email_authenticated?(:activation,params[:id])
      user.activate
      token = JsonWebToken.encode({id: user.id})
      render :activate, locals: { user: user, token: token }, status: 200
    else
      render json: { error: 'Invalid activation link' }
    end
  end
end
