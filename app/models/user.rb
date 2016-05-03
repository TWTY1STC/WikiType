class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis
  has_many :collaborators

  before_save { self.role ||= :standard}
  
  enum role: [:standard, :premium, :admin]
  
  #User can be a collaborator
  def collaborator_for(wiki)
    collaborators.where(wiki_id: wiki.id).first
  end
  
end
