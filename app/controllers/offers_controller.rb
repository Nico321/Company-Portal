class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  # GET /offers
  # GET /offers.json
  def index
    @offers = Offer.all
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
  end

  # GET /offers/new
  def new
    @offer = Offer.new
  end

  # GET /offers/1/edit
  def edit
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, notice: 'Offer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @offer }
      else
        format.html { render action: 'new' }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to edit_offer_path(@offer), notice: 'Offer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url }
      format.json { head :no_content }
    end
  end

  def convert
    @request = Request.find(params[:request_id])
    @offer = Offer.new(:subject => @request.subject, :body => @request.body)
    @offer.customer = @request.customer
    @offer.request = @request
    @offer.save
    @request.offer = @offer;
    @request.save

    redirect_to edit_offer_path(@offer.id)
  end

  def pending
    @offers = Offer.where('assignment_id IS NULL AND publication IS NOT NULL')
  end

  def open
    @offers = Offer.where('assignment_id IS NULL AND publication IS NULL')
  end

  def publish
    @offer = Offer.find(params[:id])
    @offer.publication = Time.now
    @offer.save
    redirect_to assumed_offers_path
  end

  def assume
    @offer = Offer.find(params[:id])
    @offer.agent = current_user
    @offer.save
    redirect_to assumed_offers_path
  end

  def release
    @offer = Offer.find(params[:id])
    @offer.agent = nil
    @offer.save
    redirect_to assumed_offers_path
  end
   
  def unassumed
    @offers = Offer.where('agent_id IS NULL and assignment_id IS NULL AND publication IS NULL')
  end

  def assumed
    @offers = Offer.where(agent_id: current_user.id).where('assignment_id IS NULL AND publication IS NULL')
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:subject, :body, :installationprice, :publication)
    end
end
