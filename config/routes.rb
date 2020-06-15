Rails.application.routes.draw do
  get 'movies/show'
  get 'movies/create'
  get 'movies/index'
  get 'movies/redirect'
  devise_for :users
  root to: 'pages#home'
  resources :movies, only: [:show, :create]
  get '/movies/:id/redirect', to:'movies#redirect'
  patch '/criteria', to: 'criteria#update'
  get '/users/movies', to: 'movies#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
