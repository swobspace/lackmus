module EventConcerns
  extend ActiveSupport::Concern

  included do
    scope :most_current, ->(count) { order('event_time desc').limit(count) }
    scope :by_network, ->(network) { 
       where(["src_ip <<= :ip or dst_ip <<= :ip", ip: network]) 
    }
    scope :by_sensor, ->(sensor) { where(sensor: sensor) }
    scope :by_httphost, ->(hostname) { 
      where(has_http: true, http_hostname: hostname)
    }
    scope :since, ->(timestamp) { where(["event_time >= ?", timestamp]) }
    scope :not_done, -> { where(done: false) }
    scope :not_ignored, -> { where(ignore: false) }
    scope :active, -> { where(done: false, ignore: false) }
    scope :unassigned, -> { where(event_rule_id: nil) }
    scope :today, -> { where(["event_time >= ?", Time.now.beginning_of_day]) }
    scope :yesterday, -> { where("event_time >= :start and event_time < :end", 
                                 start: (Time.now - 1.day).beginning_of_day, 
                                   end: (Time.now - 1.day).end_of_day )}
    scope :thisweek, -> { where(["event_time >= ?", Time.now.beginning_of_week]) }
    scope :lastweek, -> { where("event_time >= :start and event_time < :end", 
                                 start: (Time.now - 1.week).beginning_of_week, 
                                   end: (Time.now - 1.week).end_of_week )}
  end

  class_methods do
    def assign_filters
      EventRule.all.each do |event_rule|
        assign_filter(event_rule, Event.unassigned)
      end
    end
    
    def assign_filter(event_rule, relation)
      # relation.where(event_rule.ar_filter).update_all(event_rule_id: event_rule.id)
      EventQuery.new(filter: event_rule.filter, relation: relation).all.update_all(event_rule_id: event_rule.id)
    end
  end

  def connection
    "#{proto.upcase} #{src_ip}:#{src_port} -> #{dst_ip}:#{dst_port}"
  end

  def payload_printable
    Base64.decode64(payload).gsub(/[^[:print:]\n]/,'.')
  end

  def to_pcap
    pcap_header = PacketFu::PcapHeader.new.to_s
    pcap_header + pcap_packet
  end

  def pcap_packet
    pkt = PacketFu::Packet.parse(raw_packet)
    pkt.payload = raw_payload
    pkt.recalc

    packetfutimestamp = PacketFu::Timestamp.new(
                          sec: timestamp.to_i,
                          usec: ((timestamp.to_f - timestamp.to_i) * 10**6).to_i
                        ).to_s

    pcap_packet = PacketFu::PcapPacket.new(incl_len: pkt.size, orig_len: pkt.size,
                                           data: pkt, timestamp: packetfutimestamp)
    pcap_packet.to_s
  end

  def raw_packet
    @raw_packet ||= Base64.decode64(packet)
  end

  def raw_payload
    @raw_payload ||= Base64.decode64(payload)
  end

  # test if filter matches
  # 1. reduce all direct matching key/value pairs
  # 2. check if remaining key/values others than dst_ip, src_ip (-> nomatch)
  # 3. split filter value and test match via IPAddr#include?
  #
  def match_filter(filter = {})
    # 1. reduce
    remaining = Hash[filter].reject {|k,v| attributes[k].to_s == v.to_s }
    if remaining.empty?
      true
    else
      false
    end
  end


private

end

