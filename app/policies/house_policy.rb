class HousePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def new?
    user_loggedin?
  end

  alias create? new?
  alias search? new?

  def show?
    new? && record.user == user
  end

  alias edit? show?
  alias update? show?
  alias destroy? show?

  def export_data?
    new? && user.role.admin?
  end

  alias pdf_generator? export_data?
end
