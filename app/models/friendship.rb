class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :friend, class_name: "User"

    validates_uniqueness_of :user_id, scope: :friend_id

    validate :cannot_add_yourself
    paginates_per 2
    
    def cannot_add_yourself
      return true if user_id == friend_id else false
    end
end
