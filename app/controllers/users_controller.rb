class UsersController < ApplicationController
    # Skip authentication for user creation
    skip_before_action :authenticate, only: [:create]

    def create
        user = User.new(user_params)
        if user.save
            token = JsonWebToken.encode(user_id: user.id)
            render json: { token: token, user: user.slice(:id, :name, :email, :weight, :height) }, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        user = User.find(params[:id])
        render json: { user: user.slice(:id, :name, :email, :weight, :height) }, status: :ok
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :weight, :height)
    end
end