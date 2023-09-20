class Api::V1::SessionsController < ApplicationController
  before_action :authenticate_request, except: :login
  
  def login
    email = params[:email]
    password = params[:password]

    if email.blank? || password.blank?
      render json: { error: 'Please provide email and password' }, status: :bad_request
      return
    end
    
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      token = JsonWebToken.encode({user_id: @user.id, name: @user.name, exp: 7.days.from_now.to_i})
      render json: { token: token, user: {name: @user.name} }, status: :ok
    else
      render json: { error: 'Invalid Credentials' }, status: :unauthorized
    end  
  end
end
