class CardsController < ApplicationController
    before_action :set_wedding
    before_action :authenticate_user!
  
    def new
      @card = @wedding.cards.new
    end
  
    def create
      @card = @wedding.cards.new(card_params)
      @card.sender = current_user
      @card.recipient = User.find(params[:card][:recipient_id]) # Assuming recipient_id is passed in the params
  
      if @card.save
        flash[:notice] = "Card sent successfully!"
        redirect_to wedding_path(@wedding)
      else
        flash[:alert] = "Failed to send card: #{@card.errors.full_messages.join(', ')}"
        render :new
      end
    end
  
    private
  
    def set_wedding
      @wedding = Wedding.find(params[:wedding_id])
    end
  
    def card_params
      params.require(:card).permit(:message, :card_type, :photo, :video)
    end
  end
  