class ProfilesControllerPolicy < ApplicationPolicy
  attr_reader :user, :controller, :record

  def initialize(user, controller)
    @user = user
    @controller = controller
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    true
  end

end
