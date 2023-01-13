require "rails_helper"

RSpec.describe "routes for Pages", :type => :routing do
  it { is_expected.to route(:get, '/').to("pages#home") }
  it { is_expected.to route(:get, '/offline').to("pages#offline") }
  it { is_expected.to route(:get, '/profil/toto').to("pages#profil", slug: "toto") }
end
