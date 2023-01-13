require "rails_helper"

RSpec.describe "routes for Houses", :type => :routing do
  it { is_expected.to route(:get, '/houses').to("houses#index") }
  it { is_expected.to route(:post, '/houses').to("houses#create") }
  it { is_expected.to route(:get, '/houses/new').to("houses#new") }
  it { is_expected.to route(:get, '/houses/1/edit').to("houses#edit", id: "1") }
  it { is_expected.to route(:get, '/houses/1').to("houses#show", id: "1") }
  it { is_expected.to route(:put, '/houses/1').to("houses#update", id: "1") }
  it { is_expected.to route(:patch, '/houses/1').to("houses#update", id: "1") }
  it { is_expected.to route(:delete, '/houses/1').to("houses#destroy", id: "1") }
end
