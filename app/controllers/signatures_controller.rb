class SignaturesController < ApplicationController
  before_action :set_signature, only: [:show, :edit, :update, :destroy]
  before_action :get_signatures, only: [:index]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /signatures
  def index
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

  def destroy_events
    if params[:commit] == t('actions.destroy_all')
      @signature.events.destroy_all
    else
      @signature.events.where(['id IN (?)', event_ids]).destroy_all
    end
    redirect_to signature_path(@signature)
  end

  # send packet data for download
  def pcap
    send_data @signature.to_pcap,
      filename: "signature_#{@signature.signature_id}.pcap",
      disposition: 'attachment',
      type: 'Application/vnd.tcpdump.pcap'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_signature
      @signature = Signature.find(params[:id])
    end

    def get_signatures
      if params[:filter] == 'ignored'
        @signatures = Signature.ignored
      elsif params[:filter] == 'current'
        @signatures = Signature.current
      elsif params[:filter] == 'all'
        @signatures = Signature.all
      else
        @signatures = Signature.active
      end
    end

    def event_ids
      params[:event_ids] || []
    end

    # Only allow a trusted parameter "white list" through.
    def signature_params
      params.require(:signature).permit(:signature_id, :signature_info, :references, :action)
    end
end
