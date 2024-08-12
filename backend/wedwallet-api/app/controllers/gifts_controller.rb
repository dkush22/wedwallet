class GiftsController < ApplicationController
  require 'csv'
    # before_action :set_wedding
    before_action :authenticate_request
  
    def authenticate_request
      header = request.headers['Authorization']
      Rails.logger.info "Authorization Header: #{header}"
      header = header.split(' ').last if header
      begin
        decoded = JsonWebToken.decode(header)
        @current_user = User.find(decoded[:user_id]) if decoded
        Rails.logger.info "Authenticated user: #{@current_user.inspect}"
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError
        render json: { errors: 'Unauthorized' }, status: :unauthorized
      end
    end

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

    def download_csv
      weddings = @current_user.primary_weddings
      gifts = Gift.joins(:wedding).where(wedding: weddings).includes(:sender, :recipient)
  
      csv_data = CSV.generate(headers: true) do |csv|
        csv << ['ID', 'Sender', 'Recipient', 'Wedding', 'Amount', 'Message', 'Date Sent']
        gifts.each do |gift|
          csv << [
            gift.id,
            "#{gift.sender.first_name} #{gift.sender.last_name}",
            "#{gift.recipient.first_name} #{gift.recipient.last_name}",
            gift.wedding.title,
            gift.amount,
            gift.message,
            gift.created_at.strftime("%Y-%m-%d %H:%M:%S")
          ]
        end
      end
  
      send_data csv_data, filename: "gifts-#{Date.today}.csv", type: 'text/csv', disposition: 'attachment'
    end
  
    private
  
    # def set_wedding
    #   @wedding = Wedding.find(params[:wedding_id])
    # end
  
    def gift_params
      params.require(:gift).permit(:amount, :message)
    end


  end
  