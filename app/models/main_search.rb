class MainSearch
  def initialize(options = {})
    @options = options.symbolize_keys
    if @query = options.fetch(:q, nil)
      @ip = is_ip?(@query) ? @query : nil
    else
      @ip = options.fetch(:ip, nil)
    end
  end

  def events
    @events ||= find_events
  end

private
  attr_reader :options, :ip

  def find_events
    events = Event.order("event_time DESC")
    events = events.where(["src_ip <<= :ip or dst_ip <<= :ip", ip: ip]) unless ip.nil?
    events
  end

  def is_ip?(ip)
    !(IPAddr.new(ip) rescue nil).nil?
  end
end
