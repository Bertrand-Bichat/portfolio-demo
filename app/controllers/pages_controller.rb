class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    authorize :page, :home?
    @customers = User.with_role(:customer)
    @admins = User.with_role(:admin)
  end
end
