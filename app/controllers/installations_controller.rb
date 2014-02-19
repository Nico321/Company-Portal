class InstallationsController < ApplicationController
  before_action :set_installation, only: [:show, :edit, :update, :destroy]

  # GET /installations
  # GET /installations.json
  def index
    @installations = Installation.all
  end

  # GET /installations/1
  # GET /installations/1.json
  def show
  end

  # GET /installations/new
  def new
    @installation = Installation.new
  end

  # GET /installations/1/edit
  def edit
  end

  # POST /installations
  # POST /installations.json
  def create
    @installation = Installation.new(installation_params)

    respond_to do |format|
      if @installation.save
        format.html { redirect_to @installation, notice: 'Installation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @installation }
      else
        format.html { render action: 'new' }
        format.json { render json: @installation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /installations/1
  # PATCH/PUT /installations/1.json
  def update
    respond_to do |format|
      if @installation.update(installation_params)
        format.html { redirect_to @installation, notice: 'Installation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @installation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /installations/1
  # DELETE /installations/1.json
  def destroy
    @installation.destroy
    respond_to do |format|
      format.html { redirect_to installations_url }
      format.json { head :no_content }
    end
  end
  
 def convert
    @order = Order.find(params[:order_id])
    @installation = Installation.new(:subject => @order.subject, :body => @order.body)
    @installation.customer = @order.customer
    @installation.order = @order
    @installation.save
    @order.installation = @installation
    @order.save

    redirect_to @installation
  end

  def open
    @installations = Installation.where('invoice_id IS NULL')
  end

  def assume
    @installation = Installation.find(params[:id])
    @installation.agent = current_user
    @installation.save
    redirect_to assumed_installations_path
  end

  def release
    @installation = Installation.find(params[:id])
    @installation.agent = nil
    @installation.save
    redirect_to assumed_installations_path
  end
   
  def unassumed
    @installations = Installation.where('agent_id IS NULL and invoice_id IS NULL')
  end

  def assumed
    @installations = Installation.where(agent_id: current_user.id).where('invoice_id IS NULL')
  end 


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_installation
      @installation = Installation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def installation_params
      params.require(:installation).permit(:subject, :body, :installationdate, :invoice_id, :order_id)
    end
end
