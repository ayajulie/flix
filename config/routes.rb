Rails.application.routes.draw do
  resources :genres
  root 'movies#index'
  resources :movies do
    resources :reviews
    resources :favorites, only: %i[create destroy]
  end
  resources :users
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  resource :session, only: %i[new create destroy]
end
