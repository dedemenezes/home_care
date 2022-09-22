class RoundPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    # user.alive?
    record.user == user
  end

  def show?
    create?
  end
end
