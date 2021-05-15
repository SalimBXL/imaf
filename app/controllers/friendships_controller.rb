class FriendshipsController < ApplicationController
    before_action :find_friendship, only: [:show, :friends, :update, :destroy]


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

    def friends
        if @friendship
            friends = Friendship.where(friendship: @friendship)
            render json: friends, status: :ok
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

    private

        def friendship_params
            params.require(:friendship).permit(:user_id, :friend_id, :activities)
        end

        def find_friendship
            @friendship = Friendship.find_by_id(params[:id])
        end
  end