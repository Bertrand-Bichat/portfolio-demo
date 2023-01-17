require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # devise_scope :user do
  #   root to: "devise/sessions#new"
  # end
  # get '/users', to: 'pages#home'

  # Pages
  root to: 'pages#home'
  get '/offline', to: 'pages#offline', as: :offline
  get '/profil/:slug', to: 'pages#profil', as: :profil

  # Webhook
  namespace :webhooks do
    scope :postmark do
      post 'delivery-email', to: 'postmark_emails#delivery'
    end
  end

  # Errors
  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unacceptable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # Models
  resources :houses do
    collection do
      get :search
      get :export_data
    end
  end
  # get '/search-houses', to: 'houses#search', as: :houses_search
  # get '/export-houses-data', to: 'houses#export_data', as: :houses_export_data

  # API Endpoints
  namespace :api do
    namespace :v1 do
      resources :houses
    end
  end

  # Develomment tools
  authenticate :user, ->(user) { user.role.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
