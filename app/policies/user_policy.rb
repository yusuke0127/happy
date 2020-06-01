class UserPolicy < ApplicationPolicy
  def show?
    true
  end
  def community?
    true
  end
end
