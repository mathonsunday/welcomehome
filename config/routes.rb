SaferstallsRails::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :homes

  mount API::Base => '/api'

  get '/about', to: 'welcome#about'
  get '/text', to: 'welcome#text_msg'
  get '/contact', to: 'contacts#new'
  get '/license', to: 'welcome#license'

  root to: "welcome#index"

  resources "contacts", only: [:new, :create]
end
