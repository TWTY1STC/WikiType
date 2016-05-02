class Wiki < ActiveRecord::Base
  has_many :users, through: :collaborators

  scope :visible_to, -> (user) { user ? all : where(private: false) }
  
  def public?
    private == false || private.nil?
  end

end
