class ApplicationController < ActionController::API
  before_action :authenticate_request
    
  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      @payload = JsonWebToken.decode(token)
      @current_user = User.find(@payload['user_id'])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
