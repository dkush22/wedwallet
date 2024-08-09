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
      user = @current_user
      my_wedding = user.primary_weddings.first || user.secondary_weddings.first
      render json: {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        my_wedding: my_wedding,
        upcoming_weddings: user.attended_weddings.where('date >= ?', Date.today),
        past_weddings: user.attended_weddings.where('date < ?', Date.today)
      }
      
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