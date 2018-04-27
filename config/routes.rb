Rails.application.routes.draw do
  get 'welcome/index'

  resources :chores
  resources :houses do
    resources :chores, only: [:edit, :create, :update, :destroy] do
      member do
        post 'complete'
      end
    end
  end
  resources :users
  root 'welcome#index'

  post '/houses/:id/users', to: 'houses#add_user'
  delete '/houses/:id/users/:user_id', to: 'houses#delete_user'
  post '/users/:id/houses', to: 'users#add_house'
  delete '/users/:id/houses/:room_id', to: 'users#delete_house'
  post '/houses/:id/chores/:chore_id/complete', to: 'chores#complete'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
