class ActivityPolicy < ApplicationPolicy
  def new?
    user.present? && record.band.manager_id == user.id
  end

  [
    :practice,
    :write_song,
    :gig,
    :record_single,
    :release,
    :rest
  ].each do |symbol|
    define_method "#{symbol}?" do
      new?
    end
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
