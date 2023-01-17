require "tempfile"

class ExportToEmailJob < ApplicationJob
  queue_as :default

  def perform(element_class, element_ids, user_id, format = :csv)
    elements = element_class.constantize.where(id: element_ids)
    # export_result = exporter_class.constantize.send("call", exporter_params.merge({ elements: elements }).to_options)
    filename = "#{element_class.to_s.downcase.pluralize}_#{DateTime.now.strftime('%d-%m-%Y_%Hh%M')}.#{format}"

    file = Tempfile.new
    file.write(export_result.export_content)
    file.close

    ExportsMailer.successful_export(file.path, filename, user_id).deliver_later
  end
end
