require 'swagger_helper'

RSpec.describe "api/v1/houses", type: :request do
  before do
    @user = create(:user, :with_customer_role)
  end

  path "/api/v1/houses" do
    post("create an house") do
      tags "houses"
      consumes "application/json"
      produces "application/json"
      parameter name: :house, in: :body, schema: { '$ref' => '#/components/schemas/new_house' }

      response(201, "house created") do
        let(:house) { { name: "test", address: "34 Rue Montaigne, Petrie Queensland 4502, Australie", user_id: @user.id } }
        schema '$ref' => '#/components/schemas/house'
        run_test!
      end

      response(422, "invalid request") do
        schema '$ref' => '#/components/schemas/errors_object'
        let(:house) { {} }
        run_test! do |response|
          expect(response.body).to include("doit exister")
        end
      end
    end
  end

  path "/api/v1/houses/{id}" do
    parameter name: "id", in: :path, type: :string, description: "house id"
    let(:house) { create(:house, user: @user) }
    let(:id) { house.id }

    get("show an house") do
      tags "houses"
      consumes "application/json"
      produces "application/json"

      response(200, "successful") do
        schema "$ref" => "#/components/schemas/house"
        run_test!
      end

      response(404, description: "Record Not Found") do
        let(:id) { 'invalid' }
        schema "$ref" => "#/components/schemas/errors_not_found"
        run_test!
      end
    end

    put("update an house") do
      tags 'houses'
      consumes "application/json"
      produces "application/json"
      parameter name: :house, in: :body, schema: { '$ref' => '#/components/schemas/edit_house' }
      let(:house_bis) { create(:house, user: @user) }
      let(:id) { house_bis.id }

      response(200, "house updated") do
        run_test!
      end

      response(422, "invalid request") do
        schema '$ref' => '#/components/schemas/errors_object'
        let(:house) { { id: id, name: nil } }
        run_test! do |response|
          expect(response.body).to include("doit être rempli")
        end
      end
    end

    delete("delete an house") do
      tags "houses"
      consumes "application/json"
      produces "application/json"

      response(204, "successful") do
        run_test!
      end

      response(404, description: "Record Not Found") do
        let(:id) { 'invalid' }
        schema "$ref" => "#/components/schemas/errors_not_found"
        run_test!
      end
    end
  end
end
