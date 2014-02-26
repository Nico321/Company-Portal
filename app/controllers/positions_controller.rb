class PositionsController < ApplicationController
  before_action :set_position, only: [:show, :edit, :update, :destroy]

  # GET /positions
  # GET /positions.json
  def index
    @positions = Position.all
  end

  # GET /positions/1
  # GET /positions/1.json
  def show
  end

  # GET /positions/new
  def new
    @position = Position.new
  end

  # GET /positions/1/edit
  def edit
  end

  # POST /positions
  # POST /positions.json
  def create
    offer= Offer.find(position_params[:offer_id])
    currentPos = offer.positions.find_by(article: Article.find(position_params[:article_id]))
    if currentPos
      currentPos.quantity +=1
      currentPos.save
      redirect_to edit_offer_path(offer)
    else
      @position = Position.new(position_params)

      respond_to do |format|
        if @position.save
          format.html { redirect_to edit_offer_path(@position.offer), notice: 'Position was successfully created.' }
          format.json { render action: 'show', status: :created, location: @position }
        else
          format.html { render action: 'new' }
          format.json { render json: @position.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def updateDeliverydate
    @position = Position.find(params[:id])
    @position.deliverydate = Date.strptime(params[:deliverydate], '%Y-%m-%d')
    @position.save
    redirect_to @position.order, notice: 'Deliverydate successfully updated.'
  end

  # PATCH/PUT /positions/1
  # PATCH/PUT /positions/1.json
  def update
    respond_to do |format|
      if @position.update(position_params)
        format.html { redirect_to @position, notice: 'Position was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /positions/1
  # DELETE /positions/1.json
  def destroy
    offer = @position.offer
    @position.destroy
    respond_to do |format|
      format.html { redirect_to edit_offer_path(offer) }
      format.json { head :no_content }
    end
  end

  def arrive
    @position = Position.find(params[:id])
    @position.arrived = DateTime.now
    @position.save

    everythingArrived = true
    @position.order.positions.each do |p|
      if p.arrived == nil
        everythingArrived = false
      end
    end

    if everythingArrived
      redirect_to convert_installations_path(:order_id => @position.order.id)
    else
      redirect_to @position.order, notice: 'Position arrived.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_position
      @position = Position.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def position_params
      params.require(:position).permit(:quantity, :deliverydate, :offer_id, :article_id)
    end
end
