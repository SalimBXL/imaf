class FriendshipSerializer::UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :updated_at
end
