class HousePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    record.user == user
  end

  alias new? show?
  alias create? show?
  alias edit? show?
  alias update? show?
  alias destroy? show?
end
