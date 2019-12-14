Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#start"
  resources :microposts, only: %i[create destroy index show] do
    resources :likes, only: %i[create destroy]
  end
  resources :comments, only: [:create, :destroy, :update, :edit]
  
end
