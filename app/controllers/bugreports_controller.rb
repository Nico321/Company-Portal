class BugreportsController < ApplicationController
  before_action :set_bugreport, only: [:show, :edit, :update, :destroy]

  # GET /bugreports
  # GET /bugreports.json
  def index
    @bugreports = Bugreport.all
  end

  # GET /bugreports/1
  # GET /bugreports/1.json
  def show
  end

  # GET /bugreports/new
  def new
    @bugreport = Bugreport.new
  end

  # GET /bugreports/1/edit
  def edit
  end

  # POST /bugreports
  # POST /bugreports.json
  def create
    @bugreport = Bugreport.new(bugreport_params)
    @bugreport.reporter = current_user

    respond_to do |format|
      if @bugreport.save
        format.html { redirect_to root_url, notice: 'Bugreport was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bugreport }
      else
        format.html { render action: 'new' }
        format.json { render json: @bugreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bugreports/1
  # PATCH/PUT /bugreports/1.json
  def update
    respond_to do |format|
      if @bugreport.update(bugreport_params)
        format.html { redirect_to @bugreport, notice: 'Bugreport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bugreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugreports/1
  # DELETE /bugreports/1.json
  def destroy
    @bugreport.destroy
    respond_to do |format|
      format.html { redirect_to bugreports_url }
      format.json { head :no_content }
    end
  end

   def assume
    @bugreport = Bugreport.find(params[:id])
    @bugreport.agent = current_user
    @bugreport.save
    redirect_to assumed_bugreports_url
  end

def release
  @bugreport = Bugreport.find(params[:id])
  @bugreport.agent = nil
  @bugreport.save
  redirect_to unassumed_bugreports_url
end

def close
  @bugreport = Bugreport.find(params[:id])
  @bugreport.closed = Time.now
  @bugreport.save
  redirect_to assumed_bugreports_url
end


  def open
    @bugreports = Bugreport.where("closed is null")
  end

  def assumed
    @bugreports = Bugreport.where(agent_id: current_user.id)
  end

  def unassumed
    @bugreports = Bugreport.where("agent_id is null")
  end

def closed
  @bugreports = Bugreport.where("closed is not null")
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bugreport
      @bugreport = Bugreport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bugreport_params
      params.require(:bugreport).permit(:subject, :description, :userid, :employeeid)
    end
end
