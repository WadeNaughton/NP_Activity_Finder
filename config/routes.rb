Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope ":locale" do
    get '/', to: 'welcome#index'
  end
  
  get '/volunteer', to: 'volunteers#index'
  resources :parks do
    get "/comments", to: 'parks#park_comments'
    get '/accessible_places', to: 'parks#accessible_places'
    get '/alerts', to: 'alerts#index'
    resources :events
  end

  # get '/accessible_places', to: 'parks#accessible_places'

  # resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users do 
    get '/search_results', to: 'users#search_results'
    resources :parks do
      get '/alerts', to: 'alerts#index'
      get "/comments", to: 'parks#park_comments'
      resources :user_new_parks
      resources :events do
        resources :user_new_events do
          resources :comments
        end
      end
    end
  end
end
