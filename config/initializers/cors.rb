# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins [ENV["BLOG_SERVER_ORIGIN"], ENV["STUDIO_SERVER_ORIGIN"], 'http://localhost:3000']

    resource '/user_sessions/*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
    resource '/posts/*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
    resource '/links/*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
    resource '/admin/posts/*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
    resource '/cloudinary_signature', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end
end
