module EventConcerns
  extend ActiveSupport::Concern

  included do
    scope :most_current, ->(count) { order('event_time desc').limit(count) }
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

end

