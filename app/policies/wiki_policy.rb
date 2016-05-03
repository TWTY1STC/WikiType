class WikiPolicy < ApplicationPolicy
  
  def show?
    record.public? || user && (record.user == user || user.admin?) 
  end
  
  class Scope
    attr_reader :user, :scope
    
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all #admin user sees all wikis
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.owner == user || wiki.collaborators.include?(user)
            wikis << wiki #premium users see public, own and collaborating wikis
          end
        end
      end
      wikis
    end
  end
end
