class TalksController < ApplicationController
  before_action :set_talk, only: [:show]
  before_action :only_owner!, only: [:show]

  
  def index
    @talks = current_user.fetch_talks(params)
  end
  
  def show
    @messages = @talk.messages.includes(:user).page(params[:page])
  end
  
  def create
    redirect_to Talk.start(talk_params)
  end
  
  private
    
    def set_talk
      @talk = Talk.find(params[:id])
    end
    
    def talk_params
      params.permit(user_ids: [])
    end
    
    def only_owner!
      redirect_to talks_url unless @talk.owned?(current_user)
    end    
end
