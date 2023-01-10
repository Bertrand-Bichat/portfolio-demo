require "sidekiq/web"

Rails.application.routes.draw do
  get '/offline', to: 'pages#offline', as: :offline
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'pages#home'
  # devise_scope :user do
  #   root to: "devise/sessions#new"
  # end
  # get '/users', to: 'pages#home'

  namespace :webhooks do
    scope :postmark do
      post 'delivery-email', to: 'postmark_emails#delivery'
    end
  end

  # Sidekiq Web UI, only for admins.
  authenticate :user, ->(user) { user.role.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
