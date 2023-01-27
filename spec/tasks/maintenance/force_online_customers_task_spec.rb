# frozen_string_literal: true
require 'rails_helper'

module Maintenance
  RSpec.describe ForceOnlineCustomersTask do
    it "should set customer online to true" do
      user = create(:user, :with_customer_role)
      assert_equal false, user.online
      Maintenance::ForceOnlineCustomersTask.process(user)
      assert_equal true, user.online
    end
  end
end
