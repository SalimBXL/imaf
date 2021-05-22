Rails.application.routes.draw do

  #get "/activities", to: "activities#index"
  #get "/activities/:id", to: "activities#show"
  post "/activities", to: "activities#create"
  patch "/activities/:id", to: "activities#update"

  #get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
  post "/users", to: "users#create"
  patch "/users/:id", to: "users#update"

  #get "/friendships", to: "friendships#index"
  #get "/friendships/:id", to: "friendships#show"
  post "/friendships", to: "friendships#create"
  patch "/friendships/:id", to: "friendships#update"

  #get "/users/:id/friendships", to: "friendships#user"
  #get "/users/:id/activities", to: "activities#user"
end
