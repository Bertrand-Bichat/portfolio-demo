# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Example API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        schemas: {
          errors_not_found: {
            type: "object",
            properties: {
              message: { type: "string", example: "Record Not Found" }
            }
          },
          errors_object: {
            type: "object",
            properties: {
              errors: { '$ref' => "#/components/schemas/errors_map" }
            }
          },
          errors_map: {
            type: "object",
            additionalProperties: {
              type: "array",
              items: { type: "string" }
            }
          },
          new_house: {
            type: :object,
            description: "A house is a building",
            properties: {
              name: { type: :string, description: "The house's name.", example: "My home" },
              address: { type: :string, description: "The house's address.", example: "46 rue Paradis, 13006 Marseille" },
            },
            required: [ "name", "address" ]
          },
          edit_house: {
            type: :object,
            description: "A house is a building",
            properties: {
              name: { type: :string, description: "The house's name.", example: "My home" },
              address: { type: :string, description: "The house's address.", example: "46 rue Paradis, 13006 Marseille" },
            },
            required: [ "name", "address" ]
          },
          house: {
            type: :object,
            description: "A house is a building",
            properties: {
              id: { type: :integer, readOnly: true, minimum: 1, description: "The unique identifier of an house", example: 1 },
              user_id: { type: :integer, readOnly: true, minimum: 1, description: "The unique identifier of the house's user", example: 1 },
              name: { type: :string, description: "The house's name.", example: "My home" },
              address: { type: :string, description: "The house's address.", example: "46 rue Paradis, 13006 Marseille" },
              longitude: { "type": "string", description: "Coordinates: Longitude", example: "-73.4924,45.5458" },
              latitude: { "type": "string", description: "Coordinates: Latitude", example: "-73.4924,45.5458" },
              created_at: { type: :string, description: "Creation timestamp.", format: :"date-time" },
              updated_at: { type: :string, description: "Last update timestamp.", format: :"date-time" },
            },
            required: [ "id", "user_id", "name", "address", "created_at", "updated_at" ]
          },
        },
      },
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
