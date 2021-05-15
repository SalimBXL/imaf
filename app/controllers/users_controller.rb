class UsersController < ApplicationController
    before_action :find_user, only: [:show, :friends, :friend_of, :update, :destroy]


    def index
      @users = User.all
      render json: @users, status: :ok
    end

    def show
        if @user
            render json: @user, status: :ok
        else
            render json: {}, status: :not_found
        end
    end

    def friends
        if @user
            friends = Friendship.where(user: @user)
            render json: friends, status: :ok
        else
            render json: {}, status: :not_found
        end
    end

    def friend_of
        if @user
            friends = Friendship.where(friend: @user)
            render json: friends, status: :ok
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