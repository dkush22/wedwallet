class GiftsController < ApplicationController
    before_action :set_wedding
    before_action :authenticate_user!
  
    def new
      @gift = @wedding.gifts.new
    end
  
    def create
      @gift = @wedding.gifts.new(gift_params)
      @gift.sender = current_user
      @gift.recipient = User.find(params[:gift][:recipient_id]) # Assuming recipient_id is passed in the params
  
      if @gift.save
        flash[:notice] = "Gift sent successfully!"
        redirect_to wedding_path(@wedding)
      else
        flash[:alert] = "Failed to send gift: #{@gift.errors.full_messages.join(', ')}"
        render :new
      end
    end
  
    private
  
    def set_wedding
      @wedding = Wedding.find(params[:wedding_id])
    end
  
    def gift_params
      params.require(:gift).permit(:amount, :message)
    end
  end
  