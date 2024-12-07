Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "dotcom#index"

  devise_for :users, controllers: { registrations: 'users/registrations', invitations: 'users/invitations', sessions: 'users/sessions' }

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :rooms
      resources :messages
      resources :users, only: %i[show create]
      resource :paddle, only: [] do
        post :notification
      end
      resource :organization, only: [:show]
      resource :session, only: %i[create destroy update]
    end
  end

  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

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

  resources :rooms, only: [:show, :update, :index] do
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

  resources :contacts, only: [:create]

  resources :subscriptions, only: [:new, :create, :destroy]

  get '/settings' => 'rooms#settings', as: :settings

  get '/request-a-demo' => 'dotcom#contact_us', as: :contact_us
end
