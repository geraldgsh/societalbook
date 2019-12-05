Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  get "microposts", to: "microposts#index"
  get "microposts/new", to: "microposts#new", as: :new_microposts
  get "microposts/:id", to: "microposts#show"
  get "microposts/:id/edit", to: "microposts#edit"

  patch "microposts/:id",  to: "microposts#update", as: :micropost
  post "microposts", to: "microposts#create"
  delete "microposts/:id",  to: "microposts#destroy"
end
