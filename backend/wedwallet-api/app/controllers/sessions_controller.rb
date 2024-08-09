class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      render json: { message: "Login successful", user: user }, status: :ok
    else
      render json: { errors: ["Invalid email or password"] }, status: :unprocessable_entity
    end
  end

  def destroy
    # This would handle logouts if you implement session management
  end
end