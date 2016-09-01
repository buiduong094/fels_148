Rails.application.routes.draw do
  get "sessions/new"
  get "categories/new"

  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  post "/signup",  to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, except: [:delete] do
    member do
      get :following, :followers
    end
  end
  resources :categories, only: [:index, :show] do
    resources :lessons, only: :create
  end
  resources :words, only: [:index, :show] do
    resources :answers, only: :index
  end
  resources :lessons
  resources :relationships, only: [:create, :destroy]
  namespace :admin do
    resources :categories
    resources :users, only: [:index, :show, :destroy]
    resources :words
    get  "/create_word", to: "words#new"
    resources :words do
      resources :answers, only: :index
    end
  end
end
