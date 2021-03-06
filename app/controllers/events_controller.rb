class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]
  before_action :get_events, only: [:index]

  # GET /events
  def index
    respond_with(@events)
  end

  # GET /events/1
  def show
    respond_with(@event)
  end

  # GET /events/1/edit
  def edit
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

    def get_events
      if search_params[:all]
        @events = Event.all
      else
        @events = Event.not_done
      end
      if search_params[:sensor]
        @events = @events.by_sensor(search_params[:sensor])
      end
      if search_params[:httphost]
        @events = @events.by_httphost(search_params[:httphost])
      end
      if search_params[:ip]
        @events = @events.by_network(search_params[:ip])
      end
      if search_params[:since].present? && search_params[:since] =~ /\A(yesterday|today)\z/
        @events = @events.since(search_params[:since])
      end
      @events
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def search_params
      params.permit(:ip, :since, :all, :sensor, :httphost)
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:sensor, :event_time, :flow_id, :in_iface, :event_type, :src_ip, :src_port, :dst_ip, :dst_port, :proto, :alert_action, :alert_gid, :alert_signature_id, :alert_rev, :alert_signature, :alert_category, :alert_severity, :http_hostname, :http_xff, :http_url, :http_user_agent, :http_content_type, :http_cookie, :http_length, :http_status, :http_protocol, :http_method, :http_refer, :payload, :packet, :stream, :done, :ignore, :severity)
    end
end
