class MoodPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def insights?
    scope.where(user: user)
  end

end
