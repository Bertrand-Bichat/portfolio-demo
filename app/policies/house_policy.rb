class HousePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    record.user == user
  end

  alias edit? show?
  alias update? show?
  alias destroy? show?

  def new?
    user_loggedin?
  end

  alias create? new?
  alias search? new?
  alias export_data? new?
end
