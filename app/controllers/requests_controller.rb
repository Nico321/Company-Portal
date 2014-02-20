class RequestsController < ApplicationController
  load_and_authorize_resource
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)

    @request.customer = current_user

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @request }
      else
        format.html { render action: 'new' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url }
      format.json { head :no_content }
    end
  end

  def open    

    if params[:sort] == nil
      params[:sort] = 'customer_id'
    end
    if params[:direction] == nil
      params[:direction] = "asc"
    end
    
    @requests = Request.where('offer_id IS NULL').search(params[:search]).order(params[:sort] + " " + params[:direction]).paginate(:per_page => 5, :page => params[:page])
  end

  def unassumed    

    if params[:sort] == nil
      params[:sort] = 'customer_id'
    end
    if params[:direction] == nil
      params[:direction] = "asc"
    end
    
    @requests = Request.where('agent_id IS NULL and offer_id IS NULL').search(params[:search]).order(params[:sort] + " " + params[:direction]).paginate(:per_page => 5, :page => params[:page])
  end

  def assumed    

    if params[:sort] == nil
      params[:sort] = 'customer_id'
    end
    if params[:direction] == nil
      params[:direction] = "asc"
    end
    
    @requests = Request.where(agent_id: current_user.id).where('offer_id IS NULL').search(params[:search]).order(params[:sort] + " " + params[:direction]).paginate(:per_page => 5, :page => params[:page])
  end

  def assume
    @request = Request.find(params[:id])
    @request.agent = current_user
    @request.save
    redirect_to assumed_requests_path
  end

  def release
    @request = Request.find(params[:id])
    @request.agent = nil
    @request.save
    redirect_to assumed_requests_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:subject, :body, :urgency, :customer_id, :agent_id, :note_id, :offer_id)
    end
end
