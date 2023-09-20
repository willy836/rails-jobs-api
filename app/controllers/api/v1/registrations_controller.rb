class Api::V1::RegistrationsController < ApplicationController
  before_action :authenticate_request, except: :register
  
  def register
    @user = User.new(user_params)
    
    if @user.save
      token = JsonWebToken.encode({user_id: @user.id, name: @user.name, exp: 7.days.from_now.to_i})
      render json: { token: token, user: {name: @user.name} }, status: :created
    else
      render json: { error: 'Invalid name or password' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
