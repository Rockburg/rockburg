class MembersPolicy < ApplicationPolicy
  def destroy?
    user.present?
  end

  def show?
    true
  end

  def hire?
    user.present?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
