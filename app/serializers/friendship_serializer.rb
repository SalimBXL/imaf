class FriendshipSerializer < ActiveModel::Serializer
  attributes :id, :activities_list
  belongs_to :friend
end
