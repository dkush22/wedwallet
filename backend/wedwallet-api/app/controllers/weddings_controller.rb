class WeddingsController < ApplicationController
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

    def my_wedding
      wedding = @current_user.primary_weddings.includes(guests: :user, gifts: :sender).first
    
      if wedding
        gifts = wedding.gifts.map do |gift|
          sender_name = "#{gift.sender.first_name} #{gift.sender.last_name}"
          couple = Couple.find_by(partner1_id: gift.sender.id) || Couple.find_by(partner2_id: gift.sender.id)
    
          if couple
            partner_id = couple.partner1_id == gift.sender.id ? couple.partner2_id : couple.partner1_id
            partner = User.find(partner_id)
            sender_name = "#{sender_name} & #{partner.first_name} #{partner.last_name}"
          end
    
          {
            id: gift.id,
            amount: gift.amount,
            message: gift.message,
            sender_name: sender_name
          }
        end
    
        guests = wedding.guests.map do |guest|
          {
            id: guest.id,
            first_name: guest.user.first_name,
            last_name: guest.user.last_name,
            rsvp_status: guest.rsvp_status
          }
        end
    
        render json: { wedding: wedding, guests: guests, gifts: gifts }, status: :ok
      else
        render json: { error: 'No wedding found' }, status: :not_found
      end
    end
    
    
    

    def upcoming
      upcoming_weddings = @current_user.guests.joins(:wedding)
                                .where('weddings.date >= ?', Date.today)
                                .order('weddings.date ASC')
                                .select('weddings.*')
  
      render json: upcoming_weddings, status: :ok
    end

    def past
      past_weddings = @current_user.guests.joins(:wedding)
                               .where('weddings.date < ?', Date.today)
                               .order('weddings.date DESC')
                               .select('weddings.*')
  
      render json: past_weddings, status: :ok
    end
  
    private
  
    def wedding_params
      params.require(:wedding).permit(:title, :date, :location)
    end
  end
  