require 'rails_helper'

RSpec.describe "api/v1/houses", type: :request do
  before do
    @user = create(:user, :with_customer_role)
  end

  path "api/v1/houses" do
    post("create an house") do
      tags "houses"
      consumes "application/json"
      produces "application/json"
      parameter name: :house, in: :body, schema: { '$ref' => '#/components/schemas/new_house' }

      response(201, "house created") do
        let(:house) { { name: "test", address: "46 rue Paradis, 13006 Marseille", user: @user } }
        schema '$ref' => '#/components/schemas/house'
        run_test!
      end

      response(422, "invalid request") do
        schema '$ref' => '#/components/schemas/errors_object'
        let(:house) { {} }
        run_test! do |response|
          expect(response.body).to include(I18n.t("activerecord.errors.messages.blank"))
        end
      end
    end
  end
end
