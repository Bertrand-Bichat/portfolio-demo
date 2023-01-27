# frozen_string_literal: true

require "rails_helper"

module Maintenance
  RSpec.describe ForceOfflineCustomersTask do
    it "should set customer online to false" do
      user = create(:user, :with_customer_role, online: true)
      assert_equal true, user.online
      Maintenance::ForceOfflineCustomersTask.process(user)
      assert_equal false, user.online
    end
  end
end
