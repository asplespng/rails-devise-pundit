class Api::V1::SessionSerializer < Api::V1::BaseSerializer
  attributes :token, :email, :user_id, :created_at, :updated_at
  self.root = false

  def token
    object.authentication_token
  end

  def user_id
    object.id
  end
end