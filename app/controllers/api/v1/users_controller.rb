class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find_by id: params[:id]

    user.present? ? render(json: Api::V1::UserSerializer.new(user).to_json): head(:not_found)
  end
end