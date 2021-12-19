Rails.application.routes.draw do
  get 'errors/not_found'
  resources :people, only: %i[edit destroy update]
  #post '/people', to: 'people#update'
  #get '/people/:id/edit', to: 'people#edit'
  get '/people', to: 'people#index'

  get '/people/new', to: 'people#new'
  post '/people', to: 'people#create'

  match "/404", to: "errors#not_found", via: :all




  devise_for :users

  root 'home#index'
end
