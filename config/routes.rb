Recruiting::Application.routes.draw do
  
  resources :developer_profiles

  match "/", to: "home#index", via: [:get]
  match "/investments", to: "home#investments", :as => :investments, via: [:get]
  match "/developers", to: "home#developers", :as => :developers, via: [:get]
  match "/developers/next-steps", to: "home#next_steps", :as => :developers_next_steps, via: [:get]
  match '/accept_legal_message.js', to: 'deals#accept_legal_popup', :as => :accept_legal_popup, :via => [:get]

  resources(:deals) do
    match '/publish', to: 'deals#publish', :as => :publish, :via => [:post, :put]
    match '/unpublish', to: 'deals#unpublish', :as => :unpublish, :via => [:post, :put]
  end

  devise_scope :user do
    match '/logout', to: 'auth/sessions#destroy', :as => :logout, :via => [:get, :post]
  end
  devise_for :users, :controllers => { :registrations => "auth/registrations" }

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  root to: "home#index"

end
