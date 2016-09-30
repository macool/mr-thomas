Rails.application.routes.draw do
  devise_for :admins
  namespace :api do
    namespace :v1 do
      resource :notification,
               only: [:show, :create]
    end
  end
  resource :keepalive,
           controller: :keepalive
  root to: 'keepalive#show'
end
