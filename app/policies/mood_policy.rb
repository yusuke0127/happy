class MoodPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def new?
    true
  end

  def show?
    record.any? ? record.first.user == user : true
  end


  def insights?
    scope.where(user: user)
  end

  def create?
    true
  end
end
