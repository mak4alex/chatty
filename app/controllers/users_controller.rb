class UsersController < ApplicationController
  before_action :only_admin!, only: [:ban, :unban]
  before_action :set_user,    only: [:ban, :unban]
  
  def index
    @users = User.fetch(params)
  end
  
  def ban
    @user.ban!
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def unban
    @user.unban!
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
  
  private 
    
    def set_user
      @user = User.find(params[:id])
    end
    
end
