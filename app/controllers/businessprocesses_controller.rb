class BusinessprocessesController < ApplicationController
  before_action :set_businessprocess, only: [:show, :edit, :update, :destroy]

  # GET /businessprocesses
  # GET /businessprocesses.json
  def index
    @businessprocesses = Businessprocess.all
  end

  # GET /businessprocesses/1
  # GET /businessprocesses/1.json
  def show
  end

  # GET /businessprocesses/new
  def new
    @businessprocess = Businessprocess.new
  end

  # GET /businessprocesses/1/edit
  def edit
  end

  # POST /businessprocesses
  # POST /businessprocesses.json
  def create
    @businessprocess = Businessprocess.new(businessprocess_params)

    respond_to do |format|
      if @businessprocess.save
        format.html { redirect_to @businessprocess, notice: 'Businessprocess was successfully created.' }
        format.json { render action: 'show', status: :created, location: @businessprocess }
      else
        format.html { render action: 'new' }
        format.json { render json: @businessprocess.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businessprocesses/1
  # PATCH/PUT /businessprocesses/1.json
  def update
    respond_to do |format|
      if @businessprocess.update(businessprocess_params)
        format.html { redirect_to @businessprocess, notice: 'Businessprocess was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @businessprocess.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businessprocesses/1
  # DELETE /businessprocesses/1.json
  def destroy
    @businessprocess.destroy
    respond_to do |format|
      format.html { redirect_to businessprocesses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_businessprocess
      @businessprocess = Businessprocess.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def businessprocess_params
      params.require(:businessprocess).permit(:customerid, :subject, :request, :employeeid, :urgency, :stateid, :discount, :offer, :installationprice)
    end
end
