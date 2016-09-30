Rails.application.routes.draw do
  resource :notification,
           only: :create
end
