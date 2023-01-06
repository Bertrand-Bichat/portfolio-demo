require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # Sidekiq Web UI, only for admins.
  authenticate :user, ->(user) { user.role.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
