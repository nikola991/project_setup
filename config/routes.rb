Rails.application.routes.draw do

  use_doorkeeper
  devise_for :users
  namespace :api, defaults: { format: :json } do
    scope module: :v1 do
      resources :users
    end
  end
end
