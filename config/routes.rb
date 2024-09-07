Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "rooms#index"

  devise_for :users, controllers: { registrations: 'users/registrations' }

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :rooms
      resources :messages
      resource :session, only: %i[create destroy update]
      resources :users, only: %i[show create]
    end
  end

  resources :organizations do
    collection do
      get 'settings'
    end
  end
  resources :messages do
    collection do
      get 'settings'
    end
  end
  resources :rooms do
    collection do
      get 'appearance_setting'
    end
    resources :messages
  end
  resources :notifications, only: [] do
    collection do
      get 'settings'
    end
  end

  get '/settings' => 'rooms#settings', as: :settings
end
