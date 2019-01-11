class SongPolicy < ApplicationPolicy
  def destroy?
    user.present? && record.band.manager_id == user.id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
