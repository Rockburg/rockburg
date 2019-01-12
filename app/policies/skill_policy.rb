class SkillPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
