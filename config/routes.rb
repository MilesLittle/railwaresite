Rails.application.routes.draw do
  get 'home/index'

  resources :users, only: [:show] do
    member do
      get 'show_other'
    end
  end

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  get 'register', to: 'users#new', as: 'register'
  post 'register', to: 'users#create'

  resources :posts do
    post :upload_image, on: :collection
    resources :comments, only: [:create, :destroy] do
      resources :replies, only: [:create] # Define replies as a nested resource under comments
    end
  end

  get '/errors/error', to: 'errors#error', as: :forbidden_error

  root 'home#index'
  get '/categories/:category_id/posts', to: 'categories#show_posts', as: 'category_posts'
  resources :comments, only: [:destroy]

  get "up" => "rails/health#show", as: :rails_health_check
end
