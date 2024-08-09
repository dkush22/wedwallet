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

    def my_wedding
      wedding = @current_user.wedding
      if wedding
        render json: wedding, status: :ok
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
  