class UserMailer < ApplicationMailer
  def notification_welcome
    @user = params[:user]
    metadata['user-id'] = @user.id.to_s
    mail(
      to: @user.email,
      subject: "Bienvenue sur notre site !"
    )
  end
end
