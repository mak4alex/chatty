class Message < ApplicationRecord
  default_scope { order(created_at: :desc) }
  
  belongs_to :user
  belongs_to :talk
  
  paginates_per 20
end
