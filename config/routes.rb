Rails.application.routes.draw do
	
  get 'events/addteam'

  get 'events/register'

  get 'teams/new'

	root 'static_pages#home'

  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'

  get 'sessions/new'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get  '/signup',  to: 'users#new'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resources :events
	resources :users
	resources :teams
	resources :teams_users
end
