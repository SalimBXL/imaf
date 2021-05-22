class UsersController < ApplicationController
    before_action :find_user, only: [:show, :update, :destroy]


    def index
      @users = User.all
      render json: @users, status: :ok
    end

    def show
        if @user
            activities = Activity.where(user: @user).first
            _friendships = Friendship.where(user: @user)
            friendships = Array.new
            _friendships.each do |friendship|
                friend_activities = Activity.where(user: friendship.friend_id).first

                friendships <<  { 
                    "id": friendship.id,
                    "friend": {
                        "id": friendship.friend_id,
                        "username": friendship.friend.username,
                        "email": friendship.friend.email,
                        "friend_activities": friend_activities ? friend_activities.activities.upcase.split(" ") : [],
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
                "friendships": friendships,
                "activities": activities ? activities.activities.upcase.split(" ") : [],
            }, status: :ok
        else
            render json: {}, status: :not_found
        end
    end

    def create
        user = User.create(user_params)
        if user.save
            render json: user, status: :created
        else
            render json: user.errors.details, status: :bad_request
        end
    end

    def update
        if @user.update(user_params)
            render json: @user, status: :ok
        else
            render json: @user.errors.details, status: :bad_request
        end
    end

    def destroy
        @user.destroy
        render json: {}, status: :ok
    end

    private

        def user_params
            params.require(:user).permit(:username, :email, :password)
        end

        def find_user
            @user = User.find_by_id(params[:id])
        end
  end