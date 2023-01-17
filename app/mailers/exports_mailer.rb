require "tempfile"

class ExportsMailer < ApplicationMailer
  def successful_export(filepath, filename, user_id, temporary_file: true)
    @user = User.find(user_id)
    @filename = filename
    file = File.read(filepath)

    attachments[filename] = file

    mail(to: @user.email, subject: "Export du fichier #{@filename}")

    File.delete(filepath) if File.exist?(filepath) && temporary_file
  end
end
