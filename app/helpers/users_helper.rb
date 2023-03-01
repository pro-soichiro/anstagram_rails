module UsersHelper
  def are_you_the_parson?(user)
    user == current_user
  end
end
