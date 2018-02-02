Rails.application.routes.draw do

  devise_for :users
  namespace :api, defaults: { format: :json } do
    scope module: :v1 do
      resources :users
    end
  end
end
