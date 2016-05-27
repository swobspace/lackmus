module EventConcerns
  extend ActiveSupport::Concern

  included do
  end

  def connection
    "#{proto.upcase} #{src_ip}:#{src_port} -> #{dst_ip}:#{dst_port}"
  end

  def payload_printable
    Base64.decode64(payload).gsub(/[^[:print:]\n]/,'.')
  end

  def to_pcap
    pkt = PacketFu::Packet.parse(raw_packet)
    pkt.payload = raw_payload
    pkt.recalc
    pcap_header = PacketFu::PcapHeader.new
    pcap_packet = PacketFu::PcapPacket.new(incl_len: pkt.size,
                                           orig_len: pkt.size, data: pkt)
    pcap_header.to_s + pcap_packet.to_s
  end

  def raw_packet
    @raw_packet ||= Base64.decode64(packet)
  end

  def raw_payload
    @raw_payload ||= Base64.decode64(payload)
  end

end

