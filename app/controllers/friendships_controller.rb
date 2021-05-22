class FriendshipsController < ApplicationController
    before_action :find_friendship, only: [:show, :update, :destroy]
    before_action :find_user, only: [:user]


    def index
      @friendships = Friendship.all
      render json: @friendships, status: :ok
    end

    def show
        if @friendship
            render json: @friendship, status: :ok
        else
            render json: {}, status: :not_found
        end
    end

    def create
        friendship = Friendship.create(friendship_params)
        if friendship.save
            render json: friendship, status: :created
        else
            render json: friendship.errors.details, status: :bad_request
        end
    end

    def update
        if @friendship.update(friendship_params)
            render json: @friendship, status: :ok
        else
            render json: @friendship.errors.details, status: :bad_request
        end
    end

    def destroy
        @friendship.destroy
        render json: {}, status: :ok
    end

    def user
        if @user
            _friendships = Friendship.where(user: @user)
            friendships = Array.new
            _friendships.each do |friendship|
                friendships <<  { 
                    "id": friendship.id,
                    "friend": {
                        "id": friendship.friend_id,
                        "username": friendship.friend.username,
                        "email": friendship.friend.email,
                        "updated_at": friendship.friend.updated_at,
                    },
                    "activities": friendship.activities.upcase.split(" "),
                    "updated_at": friendship.updated_at,
                }
            end            
            render json: { 
                "user": {
                    "id": @user.id,
                    "username": @user.username,
                    "updated_at": @user.updated_at,
                },
                "friendships": friendships
            }, status: :ok
        else
            render json: { "err": "user id #{params[:id]} not found" }, status: :not_found
        end
    end


    private

        def friendship_params
            params.require(:friendship).permit(:user_id, :friend_id, :activities)
        end

        def find_friendship
            @friendship = Friendship.find_by_id(params[:id])
        end

        def find_user
            @user = User.find_by_id(params[:id])
        end
  end