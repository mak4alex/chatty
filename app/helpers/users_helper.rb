module UsersHelper
  
  def if_admin
    begin
      yield if current_user.admin?
    rescue
      # need to solve current_user in socket response
    end
  end
  
  def banned_link(user)
    if user.banned?
      render partial: 'users/unban_link', locals: { user: user }
    else
      render partial: 'users/ban_link', locals: { user: user }
    end
  end

end
