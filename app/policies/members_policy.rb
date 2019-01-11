class MembersPolicy < ApplicationPolicy
  def destroy?
    user.present?
  end

  def show?
    user.present?
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
