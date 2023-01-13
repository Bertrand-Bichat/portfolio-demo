require "rails_helper"

RSpec.describe "routes for Errors", :type => :routing do
  it { is_expected.to route(:get, '/404').to("errors#not_found") }
  it { is_expected.to route(:get, '/422').to("errors#unacceptable") }
  it { is_expected.to route(:get, '/500').to("errors#internal_server_error") }
end
