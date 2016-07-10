class Talk < ApplicationRecord
  default_scope { order(created_at: :desc) }
  
  scope :search, -> (params) do
    if params[:q].present?
      where("lower(title) LIKE ?", "%#{params[:q].downcase}%") 
    end
  end
  
  has_and_belongs_to_many :users, 
    before_add: :inc_users_count, before_remove: :dec_users_count
  has_many :messages

  paginates_per 10
  
  def self.start(params)
    talk = find_talk_with_user_ids(params[:user_ids])
    return talk if talk
    
    users = User.where(id: params[:user_ids]) 
    talk = Talk.create!(title: users.map(&:name).join(' with '))
    talk.users << users
    talk
  end
  
  def self.find_talk_with_user_ids(user_ids)
    uniq_user_ids = user_ids.uniq
    uniq_user_count = uniq_user_ids.size
    
    query = %{
      EXISTS(
        SELECT COUNT(tu.user_id) AS talkings  
        FROM talks_users tu 
        WHERE talks.id = tu.talk_id AND tu.user_id IN (?) 
        GROUP BY tu.talk_id 
        HAVING talkings = ?
      ) AND users_count = ?
    }
    where(query, uniq_user_ids, uniq_user_count, uniq_user_count).first
  end
  
  def owned?(user)
    users.exists?(user.id)
  end
  
  def last_message
    messages.order('created_at DESC').limit(1).first
  end
  
  def add_message(data, user)
    res = {}
    if user.banned?
      res[:code] = 403
      res[:body] = 'You are banned!'
    else
      message = messages.create!(
        user_id: data['user_id'],
        body:    data['body']
      )
      res[:code] = 201
      res[:body] = ApplicationController.renderer.render message
    end
    res
  end
  
  private
  
    def inc_users_count(model)
      increment!('users_count')
    end
  
    def dec_users_count(model)
      decrement!('users_count')
    end
  
end
