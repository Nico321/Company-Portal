class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  def convert
    @offer = Offer.find(params[:offer_id])
    @assignment = Assignment.new(:subject => @offer.subject, :body => @offer.body)
    @assignment.customer = @offer.customer
    @assignment.offer = @offer
    @assignment.installationprice = @offer.installationprice

    @offer.positions.each do |p|
      p.assignment = @assignment
      p.save
    end

    @assignment.save
    @offer.assignment = @assignment
    @offer.save
    
    redirect_to @assignment
  end

   def open
    @assignments = Assignment.where('order_id IS NULL')
  end

  def assume
    @assignment = Assignment.find(params[:id])
    @assignment.agent = current_user
    @assignment.save
    redirect_to assumed_assignments_path
  end

  def release
    @assignment = Assignment.find(params[:id])
    @assignment.agent = nil
    @assignment.save
    redirect_to assumed_assignments_path
  end
   
  def unassumed
    @assignments = Assignment.where('agent_id IS NULL and order_id IS NULL')
  end

  def assumed
    @assignments = Assignment.where(agent_id: current_user.id).where('order_id IS NULL')
  end

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @assignment }
      else
        format.html { render action: 'new' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:subject, :body, :installationprice)
    end
end
