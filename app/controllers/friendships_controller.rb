class FriendshipsController < ApplicationController
    before_action :find_friendship, only: [:show, :update, :destroy]
    before_action :find_user, only: [:friends, :friend_of]


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

    def friends
        if @user
            friends = Friendship.where(user: @user)
            render json: friends, status: :ok
            # render json: {
            #     "user": {
            #         "id": @user.id, 
            #         "username": @user.username
            #     },
            #     "friendships": friends
            # }, status: :ok
        else
            render json: { "err": "user id #{params[:id]} not found" }, status: :not_found
        end
    end

    def friend_of
        if @user
            friends = Friendship.where(friend: @user)
            render json: friends, status: :ok
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