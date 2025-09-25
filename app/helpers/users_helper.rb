module UsersHelper
  def user_following?(user)
    @followed_ids ||= current_user.active_relationships.pluck(:followed_id).to_set
    @followed_ids.include?(user.id)
  end

  def user_followed_relationship_id(user)
    @followed_map ||= current_user.active_relationships.pluck(:followed_id, :id).to_h
    @followed_map[user.id]
  end
end
