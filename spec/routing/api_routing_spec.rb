require "rails_helper"

RSpec.describe "routes for Api", :type => :routing do
  it { is_expected.to route(:get, '/api/v1/houses').to("api/v1/houses#index") }
  it { is_expected.to route(:post, '/api/v1/houses').to("api/v1/houses#create") }
  it { is_expected.to route(:get, '/api/v1/houses/1').to("api/v1/houses#show", id: "1") }
  it { is_expected.to route(:put, '/api/v1/houses/1').to("api/v1/houses#update", id: "1") }
  it { is_expected.to route(:patch, '/api/v1/houses/1').to("api/v1/houses#update", id: "1") }
  it { is_expected.to route(:delete, '/api/v1/houses/1').to("api/v1/houses#destroy", id: "1") }
end
