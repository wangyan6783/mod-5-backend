Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :resorts, only: [:index, :show]
      resources :events, only: [:index, :show, :create]
      resources :user_events, only: [:create, :destroy]
      resources :comments, only: [:create, :update]
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
    end
  end
end
