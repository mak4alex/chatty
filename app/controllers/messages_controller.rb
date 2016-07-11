class MessagesController < ApplicationController
  before_action :only_admin!
  
  def index
    @messages = Message.fetch(params)
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
  
end
