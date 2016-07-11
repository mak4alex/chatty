class Message < ApplicationRecord
  default_scope { order(created_at: :desc) }
  
  scope :search, -> (params) do
    if params[:q].present?
      where("lower(body) LIKE ?", "%#{params[:q].downcase}%") 
    end
  end
  
  belongs_to :user
  belongs_to :talk
  
  paginates_per 20
  
  def self.fetch(params)
    Message.all
      .search(params)
      .includes(:user)
      .page(params[:page])
  end
  
end
