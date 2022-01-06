Rails.application.routes.draw do
  resources :people, only: %i[edit destroy update]
  resources :categories, only: %i[edit destroy update]
  resources :transactions, only: %i[edit destroy update]
  #post '/people', to: 'people#update'
  #get '/people/:id/edit', to: 'people#edit'
  get '/people', to: 'people#index'
  get '/categories', to: 'categories#index'
  get '/transactions', to: 'transactions#index'

  get '/people/new', to: 'people#new'
  post '/people', to: 'people#create'

  get '/categories/new', to: 'categories#new'
  post '/categories', to: 'categories#create'
  get '/categories/:id/details', to: 'categories#details_init', as: 'categories_details_init'
  post '/categories/:id/details', to: 'categories#details', as: 'categories_details'

  get '/transactions/new', to: 'transactions#new'
  post '/transactions', to: 'transactions#create'
  get '/transactions/importants', to: 'transactions#importants'

  match "/404", to: "errors#not_found", via: :all

  devise_for :users

  root 'home#index'
end
