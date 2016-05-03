class CollaboratePolicy < ApplicationPolicy
  def create?
    user && (record.user == user || user.admin? || user.premium?)
  end
  
  def destroy?
    user && (record.user == user || user.admin? || user.premium?)
  end
  
end