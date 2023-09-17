class Api::V1::RegistrationsController < ApplicationController
  def register
    @user = User.new(user_params)
    
    if @user.save
      token = JsonWebToken.encode({user_id: @user.id, username: @user.username, exp: 7.days.from_now.to_i})
      render json: { token: token, user: {username: @user.username} }, status: :created
    else
      render json: { error: 'Invalid username or password' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
