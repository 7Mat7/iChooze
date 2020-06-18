Rails.application.routes.draw do
  get 'movies/redirect'
  devise_for :users
  root to: 'pages#home'
  resources :movies, only: [:show, :create, :index]
  get '/movies/:id/redirect', to:'movies#redirect', as: 'redirect'
  resources :criteria, only: [:edit, :create, :update]
  post '/vues/member1', to: 'vues#create_member1', as: 'member1'
  post '/vues/member2', to: 'vues#create_member2', as: 'member2'
  post '/vues/members', to: 'vues#create_members', as: 'members'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
