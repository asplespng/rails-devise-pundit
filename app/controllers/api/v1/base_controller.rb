include ActionController::HttpAuthentication::Token::ControllerMethods
include ActiveSupport::SecurityUtils
class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :destroy_session
  before_filter :authenticate_user_from_token

  def destroy_session
    request.session_options[:skip] = true
  end

  def authenticate_user_from_token
    unless authenticate_with_http_token do |token, options|
      email = options[:email].presence
      user = email && User.find_by(email: email)
      authenticated = user && secure_compare(user.authentication_token, token)
      @current_user = user if authenticated
      authenticated
    end
      head :unauthorized
    end
  end
  def default_serializer_options
    {root: false}
  end
end