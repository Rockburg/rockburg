class BandPolicy < ApplicationPolicy
  def create?
    user.present? && record.manager_id == user.id
  end

  def show?
    user.present?
  end

  def update?
    create?
  end

  def happenings?
    show?
  end

  def allmembers?
    show?
  end

  def hire_member?
    update?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
