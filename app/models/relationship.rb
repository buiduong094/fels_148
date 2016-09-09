class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
  after_create :create_follow_activity
  after_destroy :create_unfollow_activity

  private
  def create_follow_activity
    create_activity Activity.activity_types[:follow],
      I18n.t("page.activities.follow")
  end

  def create_unfollow_activity
    create_activity Activity.activity_types[:un_follow],
      I18n.t("page.activities.unfollow")
  end

  def create_activity action_type, content
    Activity.create user_id: self.follower_id, target_id: self.followed_id,
      action_type: action_type, content: content
  end
end
