class ActivitiesController < ApplicationController
    before_action :find_activity, only: [:show, :update, :destroy]
    before_action :find_user, only: [:user]


    def index
      activities = Activity.all
      render json: activities, status: :ok
    end

    def show
        if @activity
            render json: @activity, status: :ok
        else
            render json: {"err": "activity id #{params[:id]} not found"}, status: :not_found
        end
    end

    def create
        activity = Activity.create(activity_params)
        if activity.save
            render json: activity, status: :created
        else
            render json: activity.errors.details, status: :bad_request
        end
    end

    def update
        if @activity.update(activity_params)
            render json: @activity, status: :ok
        else
            render json: @activity.errors.details, status: :bad_request
        end
    end

    def destroy
        @activity.destroy
        render json: {}, status: :ok
    end

    def user
        if @user
            activities = Activity.where(user: @user)
            render json: activities, status: :ok
        else
            render json: { "err": "user id #{params[:id]} not found" }, status: :not_found
        end
    end


    private

        def activity_params
            params.require(:activity).permit(:user_id, :activities)
        end

        def find_activity
            @activity = Activity.find_by_id(params[:id])
        end

        def find_user
            @user = User.find_by_id(params[:id])
        end
  end