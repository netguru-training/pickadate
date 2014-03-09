Pickadate::Application.routes.draw do
  devise_for :users
  root to: 'events#index'
  resources :events do
    resources :users_events
  end
end
