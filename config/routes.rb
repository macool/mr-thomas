Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :notification,
               only: [:show, :create]
    end
  end
end
