class AssignmentsController < ApplicationController
  load_and_authorize_resource
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

    if params[:sort] == nil
      params[:sort] = 'customer_id'
    end
    if params[:direction] == nil
      params[:direction] = "asc"
    end
    
    @assignments = Assignment.where('order_id IS NULL').search(params[:search]).order(params[:sort] + " " + params[:direction]).paginate(:per_page => 5, :page => params[:page])
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

    if params[:sort] == nil
      params[:sort] = 'customer_id'
    end
    if params[:direction] == nil
      params[:direction] = "asc"
    end
    
    @assignments = Assignment.where('agent_id IS NULL and order_id IS NULL').search(params[:search]).order(params[:sort] + " " + params[:direction]).paginate(:per_page => 5, :page => params[:page])
  end

  def assumed    

    if params[:sort] == nil
      params[:sort] = 'customer_id'
    end
    if params[:direction] == nil
      params[:direction] = "asc"
    end
    
    @assignments = Assignment.where(agent_id: current_user.id).where('order_id IS NULL').search(params[:search]).order(params[:sort] + " " + params[:direction]).paginate(:per_page => 5, :page => params[:page])
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

    def convert_from_cart
      if current_user
          @cart = Cart.find(session[:cart_id])
          @request = Request.create(subject: "StoreOrder", customer: current_user, urgency: 1, body: "StoreOrder")
          @offer = Offer.create(subject: "StoreOrder", customer: current_user, request: @request)
          @request.offer = @offer
          @request.save

          @assignment = Assignment.create(subject: "StoreOrder", customer: current_user, offer: @offer)
          @offer.assignment = @assignment
          @offer.save

          @cart.line_items.each do |line_item|
            @position = Position.create(quantity: line_item.quantity, article: line_item.article, assignment: @assignment, offer: @offer)
          end
          @cart.destroy

          redirect_to @assignment
        else
          redirect_to new_user_session_path
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
