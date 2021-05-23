class FriendshipSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :activities_list
  belongs_to :friend
end
