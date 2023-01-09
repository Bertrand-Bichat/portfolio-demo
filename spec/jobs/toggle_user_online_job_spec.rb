require 'rails_helper'

RSpec.describe ToggleUserOnlineJob, type: :job do
  describe "#perform_later" do
    before do
      create(:user, :with_customer_role)
    end
    it "should have enqueued the job on critical queue with no wait" do
      ActiveJob::Base.queue_adapter = :test
      expect { ToggleUserOnlineJob.perform_later(User.last.id, true) }.to have_enqueued_job.on_queue("critical").at(:no_wait).exactly(:once)
    end
  end
end
