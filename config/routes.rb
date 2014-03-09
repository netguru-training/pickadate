Pickadate::Application.routes.draw do
  devise_for :users
  resources :users
  root 'events#index'
  resources :events do
    member do
      get 'invite'
    end
  end

end
