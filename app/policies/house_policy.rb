class HousePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user).order(name: :asc)
    end
  end

  def show?
    record.user == user
  end

  def new?
    user_loggedin?
  end

  alias create? new?
  alias edit? show?
  alias update? show?
  alias destroy? show?
end
