Rails.application.routes.draw do
  get 'movies/redirect'
  devise_for :users
  root to: 'pages#home'
  resources :movies, only: [:show, :create, :index]
  get '/movies/:id/redirect', to:'movies#redirect', as: 'redirect'
  resources :criteria, only: [:edit, :create, :update]
  post '/vues', to: 'vues#create', as: 'vue'
  post '/vues/watch', to: 'vues#watch', as: 'watch'
  get '/vues', to: 'vues#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
