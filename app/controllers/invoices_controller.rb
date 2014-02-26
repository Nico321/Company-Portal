class InvoicesController < ApplicationController
  load_and_authorize_resource

  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # GET /invoices
  # GET /invoices.json
  def index    

    if params[:sort] == nil
      params[:sort] = 'customer_id'
    end
    if params[:direction] == nil
      params[:direction] = "asc"
    end
    
    @invoices = Invoice.where("payed IS NULL").search(params[:search]).order(params[:sort] + " " + params[:direction]).paginate(:per_page => 5, :page => params[:page])
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "file_name", :template => 'invoices/show.html.erb', :encoding => "utf-8"
      end
    end
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render action: 'show', status: :created, location: @invoice }
      else
        format.html { render action: 'new' }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url }
      format.json { head :no_content }
    end
  end

  def convert
    @installation = Installation.find(params[:installation_id])
    @invoice = Invoice.new(:subject => @installation.subject, :body => @installation.body)
    @invoice.customer = @installation.customer
    @invoice.installation = @installation
    @invoice.installationprice = @installation.order.assignment.installationprice
    @invoice.save

    @installation.order.positions.each do |p|
      p.invoice = @invoice
      p.save
    end

    @installation.invoice = @invoice;
    @installation.save

    UserMailer.create_invoice(@invoice.customer).deliver

    if current_user.has_role? :technician
      redirect_to assumed_installations_path
    else
      redirect_to @invoice
    end
  end

  def payed
    @invoice = Invoice.find(params[:invoice_id])
    @invoice.payed = DateTime.now
    @invoice.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:subject, :body, :installation_id, :agent_id, :customer_id, :installationprice)
    end
end
