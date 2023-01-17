class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.to_csv(attributes)
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |model|
        csv << attributes.map { |attr| model.send(attr) }
      end
    end
  end
end
