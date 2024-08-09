class WeddingsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @wedding = Wedding.create_with_host(current_user, wedding_params)
  
      if @wedding.is_a?(Wedding)
        flash[:notice] = "Wedding created successfully with #{current_user.first_name} as the host!"
        redirect_to wedding_path(@wedding)
      else
        flash[:alert] = "Failed to create wedding: #{@wedding.join(', ')}"
        render :new
      end
    end
  
    private
  
    def wedding_params
      params.require(:wedding).permit(:title, :date, :location)
    end
  end
  