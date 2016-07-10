class User < ApplicationRecord
  default_scope { order(name: :asc) }
  
  ROLES = {
    admin: 'admin',
    none: ''
  }
  
  STATUSES = {
    banned: 'banned',
    none: ''
  }
  
  scope :search, -> (params) do
    if params[:q].present?
      where("lower(name) LIKE ?", "%#{params[:q].downcase}%") 
    end
  end

  has_and_belongs_to_many :talks
  has_many :messages
         
  validates :name, uniqueness: true, length: { in: 3...32 }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  paginates_per 15
  
  def self.fetch(params)
    User.all.search(params).page(params[:page])
  end
  
  def fetch_talks(params)
    talks.search(params).page(params[:page])
  end
  
  def ban!
    update_attribute :status, STATUSES[:banned]
  end
  
  def unban!
    update_attribute :status, STATUSES[:none]
  end
  
  def admin?
    role == ROLES[:admin]
  end
  
  def banned?
    status == STATUSES[:banned]
  end
  
end
