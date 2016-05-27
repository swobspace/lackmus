class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /events
  def index
    @events = Event.all
    respond_with(@events)
  end

  # GET /events/1
  def show
    respond_with(@event)
  end

  # GET /events/new
  def new
    @event = Event.new
    respond_with(@event)
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    @event.save
    respond_with(@event)
  end

  # PATCH/PUT /events/1
  def update
    @event.update(event_params)
    respond_with(@event)
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    respond_with(@event)
  end

  # send packet data for download
  def packet
    send_data @event.to_pcap,
      filename: "event_#{@event.id}.pcap",
      disposition: 'attachment',
      type: 'Application/vnd.tcpdump.pcap'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:sensor, :event_time, :flow_id, :in_iface, :event_type, :src_ip, :src_port, :dst_ip, :dst_port, :proto, :alert_action, :alert_gid, :alert_signature_id, :alert_rev, :alert_signature, :alert_category, :alert_severity, :http_hostname, :http_xff, :http_url, :http_user_agent, :http_content_type, :http_cookie, :http_length, :http_status, :http_protocol, :http_method, :http_refer, :payload, :packet, :stream, :done, :ignore, :severity)
    end
end
