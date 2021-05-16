class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  def activities_list
    self.activities.split(" ");
  end

end
