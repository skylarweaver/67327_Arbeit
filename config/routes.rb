Arbeit::Application.routes.draw do

  # Routes for main resources
  resources :domains
  resources :projects
  resources :tasks
  resources :assignments
  resources :users
  resources :sessions
  
  # Authentication routes
  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'reset_password/:id' => 'users#reset_password', :as => :reset_password
  match 'password_reset' => 'users#password_reset', :as => :password_reset
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login

  # Semi-static page routes
  match 'home' => 'home#home', :as => :home
  match 'search' => 'home#search', :as => :search
  match 'cylon' => 'errors#cylon', :as => :cylon
  match 'statics' => 'statics#show', :as => 'statics'
  
  # Set the root url
  root :to => 'home#home'  
  
  # Named routes
  match 'completed/:id' => 'tasks#complete', :as => :complete
  match 'incomplete/:id' => 'tasks#incomplete', :as => :incomplete
  
  # Last route in routes.rb that essentially handles routing errors
  match '*a', :to => 'errors#routing'
end
