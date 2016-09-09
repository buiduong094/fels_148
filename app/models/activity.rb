class Activity < ActiveRecord::Base
  belongs_to :user
  enum activity_types: [:create_lesson, :finish_lession, :follow, :un_follow]

  QUERY_ACTIVYTIES_IN_USER = "user_id = :user_id OR user_id in (select followed_id
    FROM relationships where follower_id = :user_id)"
  scope :activity_in_user, -> user_id do
    where QUERY_ACTIVYTIES_IN_USER, user_id: user_id
  end
end
