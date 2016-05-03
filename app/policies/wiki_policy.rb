class WikiPolicy < ApplicationPolicy
  
  def show?
    record.public? || user && (record.user == user || user.admin? || record.users.include?(user)) 
  end
  
  def edit?
    show?
  end
  
  class Scope
    attr_reader :user, :scope
    
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    def resolve
      wikis = []
      if user
        if user.role == 'admin'
          wikis = scope.all #admin user sees all wikis
        else
          all_wikis = scope.all
          all_wikis.each do |wiki|
            if wiki.public? || wiki.user == user || wiki.users.include?(user)
              wikis << wiki #all users see public, own and collaborating wikis
            end
          end
        end
        wikis
      else
        scope.where(private: false)
      end
    end
  end
end
