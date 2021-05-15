Rails.application.routes.draw do

  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
  get "/users/:id/friends", to: "users#friends"
  get "/users/:id/friend_of", to: "users#friend_of"
  post "/users", to: "users#create"
  patch "/users/:id", to: "users#update"

  get "/friendships", to: "friendships#index"
  get "/friendships/:id", to: "friendships#show"
  post "/friendships", to: "friendships#create"
  patch "/friendships/:id", to: "friendships#update"
end
