Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '/api/v1/*',
        headers: :any,
        expose: ["Link", "Etag", "X-Page", "X-Per-Page", "X-Total", "Cache-Control", "Content-Type"],
        methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
