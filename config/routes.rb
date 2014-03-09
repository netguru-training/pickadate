Pickadate::Application.routes.draw do
  devise_for :users
  resources :users
  root to: 'events#index'
  resources :events
end
