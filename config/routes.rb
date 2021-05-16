Rails.application.routes.draw do

  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
  post "/users", to: "users#create"
  patch "/users/:id", to: "users#update"

  get "/friendships", to: "friendships#index"
  get "/friendships/:id", to: "friendships#show"
  post "/friendships", to: "friendships#create"
  patch "/friendships/:id", to: "friendships#update"

  get "/users/:id/friends", to: "friendships#friends"
  get "/users/:id/friend_of", to: "friendships#friend_of"
end
