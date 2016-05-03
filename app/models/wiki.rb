class Wiki < ActiveRecord::Base
  has_many :collaborators
  has_many :users, through: :collaborators
  
  belongs_to :user

  scope :visible_to, -> (user) { user ? all : where(private: false) }
  
  def public?
    private == false || private.nil?
  end

end
