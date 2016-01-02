class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes :id, :email, :created_at, :updated_at
end