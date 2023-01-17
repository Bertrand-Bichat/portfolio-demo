require "tempfile"

class ExportToEmailJob < ApplicationJob
  queue_as :default

  def perform(attributes:, element_class:, user_id:)
    filename = "#{element_class.to_s.downcase.pluralize}_#{DateTime.now.strftime('%d-%m-%Y_%Hh%M')}.csv"
    csv = element_class.constantize.to_csv(attributes)

    file = Tempfile.new
    file.write(csv)
    file.close

    ExportsMailer.successful_export(file.path, filename, user_id).deliver_later
  end
end
