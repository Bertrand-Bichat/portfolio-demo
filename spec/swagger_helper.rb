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
          new_event: {
            type: :object,
            description: "An event is a timely object happening in time",
            properties: {
              intent: { type: :string, description: "The type of event.", enum: ["event", "note", "task"], example: "event" },
              user_id: { type: :integer, minimum: 1, description: "The creator user id", example: 1 },
              title: { type: :string, description: "The event's title.", example: "Important meeting" },
              body: { type: :string, description: "The description (rich text).", example: "More info about that event" },
              due_at: { type: :string, description: "The event's due date.", format: :"date-time" },
              start_at: { type: :string, description: "The event's start date time.", format: :"date-time" },
              end_at: { type: :string, description: "The event's ned date time.", format: :"date-time" },
              subject_gid: { type: :string, description: "The parent's (ex: Person or organization) unique global identifier id", example: "gid://app/Person/1" },
              person_ids: { type: :array, items: { type: "integer" }, description: "The event's participant ids.", default: [] }
            },
            required: [ "title", "person_ids" ]
          },
          edit_event: {
            type: :object,
            description: "An event is a timely object happening in time",
            properties: {
              intent: { type: :string, description: "The type of event.", enum: ["event", "note", "task"], example: "event" },
              user_id: { type: :integer, minimum: 1, description: "The creator user id", example: 1 },
              title: { type: :string, description: "The event's title.", example: "Important meeting" },
              body: { type: :string, description: "The description (rich text).", example: "More info about that event" },
              due_at: { type: :string, description: "The event's due date.", format: :"date-time" },
              start_at: { type: :string, description: "The event's start date time.", format: :"date-time" },
              end_at: { type: :string, description: "The event's end date time.", format: :"date-time" },
              completed_at: { type: :string, description: "The event's date time of completion.", format: :"date-time" },
              person_ids: { type: :array, items: { type: "integer" }, description: "The event's participant ids.", default: [] }
            },
            required: [ "title", "person_ids" ]
          },
          event: {
            type: :object,
            description: "An event is a timely object happening in time",
            properties: {
              id: { type: :integer, readOnly: true, minimum: 1, description: "The unique identifier of an event", example: 1 },
              account_id: { type: :integer, readOnly: true, minimum: 1, description: "The unique identifier of the event's account", example: 1 },
              body: { type: :string, description: "The description (rich text).", example: "More info about that event" },
              intent: { type: :string, description: "The type of event.", enum: ["event", "note", "task"], example: "event" },
              gid: { type: :string, readOnly: true, description: "The unique global identifier id", example: "gid://app/Comment/1" },
              subject_gid: { type: :string, readOnly: true, description: "The parent's (ex: Person or organization) unique global identifier id", example: "gid://app/Person/1" },
              title: { type: :string, description: "The event's title.", example: "Important meeting" },
              due_at: { type: :string, description: "The event's due date.", format: :"date-time" },
              start_at: { nullable: true, type: :string, description: "The event's start date time.", format: :"date-time" },
              end_at: { nullable: true, type: :string, description: "The event's end date time.", format: :"date-time" },
              completed: { type: :boolean, description: "The event is completed." },
              completed_at: { nullable: true, type: :string, description: "The event's date time of completion.", format: :"date-time" },
              participants: {
                "type": "array",
                "items": { "$ref": "#/components/schemas/person" },
                "default": []
              }
            },
            required: [ "id", "title" ]
          },
        },
      },
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
