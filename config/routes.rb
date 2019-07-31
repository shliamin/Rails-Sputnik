Rails.application.routes.draw do
  root to: 'cities#index'
  resources :cities, except: :index do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :activities
  end
end
