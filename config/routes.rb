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

  resources :users, except: [:delete]
  resources :categories, only: [:index]
  resources :words, only: [:index, :show]

  namespace :admin do
    resources :categories, except: [:destroy, :update]
    resources :users, only: [:index, :show, :destroy]

    resources :categories, only: [:index, :new, :create]
  end

end
