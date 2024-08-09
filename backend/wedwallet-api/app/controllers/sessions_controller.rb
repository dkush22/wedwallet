class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { message: "Login successful", authToken: token }, status: :ok
    else
      render json: { errors: ["Invalid email or password"] }, status: :unprocessable_entity
    end
  end

  def destroy
    # This would handle logouts if you implement session management
  end
end