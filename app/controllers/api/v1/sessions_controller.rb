include ActionController::HttpAuthentication::Basic::ControllerMethods
class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_filter :authenticate_user_from_token, only: :create
  def create
    authenticate_with_http_basic do |email, password|
      user = User.find_by email: email
      if user && user.valid_password?(password)
        render json: {token: user.authentication_token}, status: 200 and return
      else
        head :unauthorized and return
      end
    end
    head :unprocessable_entity
  end
end