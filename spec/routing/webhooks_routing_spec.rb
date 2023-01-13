require "rails_helper"

RSpec.describe "routes for Webhooks", :type => :routing do
  it { is_expected.to route(:post, '/webhooks/postmark/delivery-email').to("webhooks/postmark_emails#delivery") }
end
