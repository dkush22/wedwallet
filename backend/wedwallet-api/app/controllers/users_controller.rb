class UsersController < ApplicationController

  before_action :authenticate_request, only: [:show_current_user]


    def index
      @users = User.all
      render json: @users
    end
  
    def show
      @user = User.find(params[:id])
      render json: @user
    end

    def show_current_user
      render json: { first_name: @current_user.first_name, last_name: @current_user.last_name, email: @current_user.email }
    end
  
    def create
      user = User.new(user_params)
      if user.save
        token = JsonWebToken.encode(user_id: user.id)
        render json: { message: "User created successfully", authToken: token }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
  end  