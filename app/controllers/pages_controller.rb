class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :offline, :language]

  def home
    authorize :page, :home?
    @customers = User.with_role(:customer).includes([:avatar_attachment]).order(id: :asc)
    @admins = User.with_role(:admin).includes([:avatar_attachment]).order(id: :asc)
  end

  def offline
    authorize :page, :offline?
    render 'offline', layout: false
  end

  def profil
    authorize :page, :profil?
    @user = User.find(params[:slug])
    @houses_geocoded = @user.houses&.geocoded
    @markers = @houses_geocoded&.map do |house|
      {
        lat: house.latitude,
        lng: house.longitude,
        info_window: render_to_string(partial: "shared/info_window", locals: { house: house, path: house_path(house) }),
        image_url: helpers.asset_url('pointer.png')
      }
    end
  end

  def language
    authorize :page, :language?
    locale = params[:locale]
    session[:locale] = locale || I18n.default_locale
    redirect_back(fallback_location: root_path)
  end
end
