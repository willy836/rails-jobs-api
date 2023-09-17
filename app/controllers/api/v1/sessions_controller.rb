class Api::V1::SessionsController < ApplicationController
  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      # User found and password verified
      token = JsonWebToken.encode({user_id: @user.id, username: @user.username, exp: 7.days.from_now.to_i})
      render json: { token: token, user: {username: @user.username} }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end  
  end
end
