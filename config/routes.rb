Rails.application.routes.draw do
  devise_for :admins
  namespace :admin do
    root to: 'subscribers#index'
    resource :keepalives, only: :show
    resources :admins, only: :index
    resources :subscribers do
      member do
        post :regenerate_token
      end
    end
  end
  namespace :api do
    namespace :v1 do
      resource :recaptcha,
               only: :show
      resource :notification,
               only: [:show, :create]
    end
  end
  resource :keepalive,
           controller: :keepalive
  root to: 'keepalive#show'
end
