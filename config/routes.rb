# config/routes.rb

Rails.application.routes.draw do
  root to: 'cities#index'
  devise_for :visitors

  resources :cities, except: :index do
    resources :activities
  end

  resources :activities, only: [:show, :edit, :update, :destroy]

  get 'home', to: 'home#index'
end
