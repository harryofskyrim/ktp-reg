Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resources :events
	resources :users
end
