class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :offline]

  def home
    authorize :page, :home?
    @customers = User.with_role(:customer)
    @admins = User.with_role(:admin)
  end

  def offline
    render 'offline', layout: false
  end
end
