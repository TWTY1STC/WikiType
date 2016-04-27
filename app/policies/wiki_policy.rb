class WikiPolicy < ApplicationPolicy
  
  def show
    record.public? || user && (record.user == user || user.admin?) 
  end
  
  class Scope < Scope
    def resolve
      if false # user && user.admin?
        scope.all
      elsif user
        wikis = []
        wikis << scope.where(private: false)
        wikis << scope.where(user_id: user.id)
        wikis.flatten.uniq
      else
        scope.where(private: false)
      end
    end
  end
end
