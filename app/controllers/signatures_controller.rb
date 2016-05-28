class SignaturesController < ApplicationController
  before_action :set_signature, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /signatures
  def index
    @signatures = Signature.all
    respond_with(@signatures)
  end

  # GET /signatures/1
  def show
    respond_with(@signature)
  end

  # GET /signatures/new
  def new
    @signature = Signature.new
    respond_with(@signature)
  end

  # GET /signatures/1/edit
  def edit
  end

  # POST /signatures
  def create
    @signature = Signature.new(signature_params)

    @signature.save
    respond_with(@signature)
  end

  # PATCH/PUT /signatures/1
  def update
    @signature.update(signature_params)
    respond_with(@signature)
  end

  # DELETE /signatures/1
  def destroy
    @signature.destroy
    respond_with(@signature)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_signature
      @signature = Signature.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def signature_params
      params.require(:signature).permit(:signature_id, :signature_info, :references, :action)
    end
end
