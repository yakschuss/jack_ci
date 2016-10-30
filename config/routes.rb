Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "oauth" }
  get 'pages/index'

  root "pages#index"
end
