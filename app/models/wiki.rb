class Wiki < ActiveRecord::Base
  belongs_to :user

  #scope :visible_to, -> (user) { user ? all : where(private: false) }
  
  def public?
    private == false || private.nil?
  end
  
end
