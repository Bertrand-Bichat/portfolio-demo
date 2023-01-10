class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :offline]

  def home
    authorize :page, :home?
    @customers = User.with_role(:customer).includes([:avatar_attachment])
    @admins = User.with_role(:admin).includes([:avatar_attachment])
  end

  def offline
    authorize :page, :offline?
    render 'offline', layout: false
  end

  def profil
    authorize :page, :profil?
    @user = User.find(params[:slug])
  end
end
