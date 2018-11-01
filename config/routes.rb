Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :resorts, only: [:index, :update]
      resources :events, only: [:index, :update]
    end
  end
end
