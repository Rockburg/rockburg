class ManagerPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def update?
    user && record.id == user.id
  end

  def show?
    true
  end

  def file_bankruptcy?
    update?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
