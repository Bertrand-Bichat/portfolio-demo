# frozen_string_literal: true

module Maintenance
  class OfflineCustomersTask < MaintenanceTasks::Task
    def collection
      # Collection to be iterated over
      # Must be Active Record Relation or Array
  # discard_on ActiveJob::DeserializationError
      User.unscoped.where(role: "customer")
    end

    def process(element)
      # The work to be done in a single iteration of the task.
      # This should be idempotent, as the same element may be processed more
      # than once if the task is interrupted and resumed.
      element.update_columns(online: true)
    end

    def count
      # Optionally, define the number of rows that will be iterated over
      # This is used to track the task's progress
      collection.count
    end
  end
end
