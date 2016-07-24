module SignatureConcerns
  extend ActiveSupport::Concern

  included do
    scope :active, -> { 
      where(["action NOT IN (?)", ['drop', 'ignore']])
    }
    scope :ignored, -> { where(["action IN (?)", ['drop', 'ignore']]) }
  end

  def last_seen
    return "" unless ( events_count > 0 )
    evnt  = events.active.order('event_time desc').first
    return nil unless evnt.present?
    days  = (Time.now - evnt.event_time).to_i / 86400
    "#{evnt.event_time.to_s(:precision)} [#{evnt.sensor}] (#{days}d)"
  end

  def to_pcap
    pcap_header = PacketFu::PcapHeader.new.to_s
    pcap_header + events.map(&:pcap_packet).join('')
  end

end

