class NotesController < ApplicationController
  load_and_authorize_resource
  before_action :set_note, only: [:show, :edit, :update, :destroy]
 
  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

    @note.user = current_user

    respond_to do |format|
      if @note.save
        if @note.request
          format.html { redirect_to @note.request, notice: 'Note was successfully created.' }
        elsif @note.offer
          format.html { redirect_to @note.offer, notice: 'Note was successfully created.' }
        elsif @note.bugreport
          format.html { redirect_to @note.bugreport, notice: 'Note was successfully created.' }
        elsif @note.assignment
          format.html { redirect_to @note.assignment, notice: 'Note was successfully created.' }
        elsif @note.order
          format.html { redirect_to @note.order, notice: 'Note was successfully created.' }
        elsif @note.installation
          format.html { redirect_to @note.installation, notice: 'Note was successfully created.' }
        elsif @note.invoice
          format.html { redirect_to @note.invoice, notice: 'Note was successfully created.' }
        end
        format.json { render action: 'show', status: :created, location: @note }
      else
        format.html { render action: 'new' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:subject, :body, :imageurl, :request_id, :offer_id, :bugreport_id, :assignment_id, :order_id, :installation_id, :invoice_id)
    end
end
