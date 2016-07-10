module UsersHelper
  
  def if_admin
    yield if current_user.admin?
  end
  
  def banned_link(user)
    if user.banned?
      render partial: 'users/unban_link', locals: { user: user }
    else
      render partial: 'users/ban_link', locals: { user: user }
    end
  end

end
