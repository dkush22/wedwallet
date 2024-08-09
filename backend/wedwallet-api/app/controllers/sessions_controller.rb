class SessionsController < ApplicationController
    def create
      @user = User.find_by(email: params[:email])
      if @user&.authenticate(params[:password])
        render json: @user
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  
    def destroy
      # Handle logout logic here, if necessary
    end
  end  