class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone_number, :status, :email
end
