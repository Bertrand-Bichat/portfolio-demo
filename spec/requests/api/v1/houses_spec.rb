require 'rails_helper'

RSpec.describe "api/v1/houses", type: :request do
  before do
    @user = create_user_and_login
  end

  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
  end
end
