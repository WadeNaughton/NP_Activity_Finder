Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index'
  
  resources :parks do
    resources :events
  end

  # resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users do 
    resources :parks do
    resources :user_new_parks
      resources :events do
        resources :user_new_events
      end
    end
  end
end
