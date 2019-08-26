Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      get '/dashboard', to: 'dashboards#index', as: 'dashboard'
      delete 'my_list/:type/:id', to: 'favorites#destroy'

      resources :favorites, path: "my_list", only: %i( index create )
      resources :searches, path: "search", only: :index
      resources :series, only: :show
      resources :recommendations, only: :show

      resources :movies, only: :show do
        member do
          get '/executions', to: 'executions#show'
          put '/executions', to: 'executions#update'
        end
      end
    end
  end
end
