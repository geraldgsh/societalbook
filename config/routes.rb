Rails.application.routes.draw do

  # devise_for :users, controllers: { registrations: 'users/registrations', :omniauth_callbacks => 'users/omniauth_callbacks' }
  # devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  root to: "home#start"
  resources :microposts, only: %i[create destroy index show] do
    resources :likes, only: %i[create destroy]
  end
  get '/users/auth/facebook/callback', to: redirect('/auth/facebook/callback')
  devise_for :users, controllers: { registrations: 'users/registrations', :omniauth_callbacks => 'users/omniauth_callbacks' }, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  resources :comments, only: [:create, :destroy, :update, :edit]
  authenticated :user do
    get 'users/:user_id/friends', to: 'users#friends', as: 'users_friends'
    get 'users', to: 'users#index', as: 'users'
    get 'friend_requests/', to: 'users#friend_requests', as: 'user_friend_requests'
    post 'friend_request/:requestee_user_id', to: 'friendships#create', as: 'friend_request'
    put 'friend_requests/:requestee_user_id/:requested_user_id', to: 'friendships#accept', as: 'accept_friend_request'
    delete 'friend_requests/:requester_user_id/:requestee_user_id', to: 'friendships#delete', as: 'delete_friend_request'
  end

end
