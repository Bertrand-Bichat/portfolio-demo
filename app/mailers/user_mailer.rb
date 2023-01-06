class UserMailer < ApplicationMailer
  def notification_welcome
    @user = params[:user]
    mail(
      to: @user.email,
      subject: "Bienvenue sur notre site !"
    )
  end
end
