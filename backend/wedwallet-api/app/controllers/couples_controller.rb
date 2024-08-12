class CouplesController < ApplicationController
    before_action :set_couple, only: [:show, :update, :destroy]
  
    # GET /couples
    def index
      @couples = Couple.all
      render json: @couples
    end
  
    # GET /couples/:id
    def show
      render json: @couple
    end
  
    # POST /couples
    def create
      @couple = Couple.new(couple_params)
      if @couple.save
        render json: @couple, status: :created
      else
        render json: @couple.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /couples/:id
    def update
      if @couple.update(couple_params)
        render json: @couple
      else
        render json: @couple.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /couples/:id
    def destroy
      @couple.destroy
      head :no_content
    end
  
    private
  
    def set_couple
      @couple = Couple.find(params[:id])
    end
  
    def couple_params
      params.require(:couple).permit(:partner1_id, :partner2_id)
    end
  end  