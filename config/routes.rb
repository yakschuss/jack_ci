Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "oauth" }
  get "pages/index"
  resources :dashboard, only: [:show]
  post "/toggle_webhook", to: "webhook#toggle_pull_request_webhook"
  root "pages#index"
end
