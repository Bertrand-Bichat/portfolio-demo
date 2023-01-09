require 'rails_helper'

RSpec.describe ToggleUserOnlineJob, type: :job do
  describe "#perform_later" do
    it "should have enqueued the job" do
      create(:user, :with_customer_role)
      ActiveJob::Base.queue_adapter = :test
      expect { ToggleUserOnlineJob.perform_later(User.last.id, true) }.to have_enqueued_job
    end
  end
end
