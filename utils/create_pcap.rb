#!/usr/bin/env ruby
# -*- encoding : utf-8 -*-

ENV['RAILS_ENV'] ||= 'development'
require File.dirname(__FILE__) + '/../config/environment.rb'

event_id = ARGV[0]

event = Event.where(id: event_id).first || Event.last

payload = Base64.decode64(event.payload)

# build a fake ip and proto header
ip = PacketFu::IPHeader.new(ip_src: event.src_ip.to_s, ip_dst: event.dst_ip.to_s)

if event.proto == 'TCP'
  pkt = PacketFu::TCPPacket.new
  pkt.tcp_src = event.src_port
  pkt.tcp_dst = event.dst_port
  pkt.ip_src = event.src_ip.to_s
  pkt.ip_dst = event.dst_ip.to_s

  pkt.payload = payload
  pkt.recalc
elsif event.proto == 'UDP'
#   ip =+ PacketFu::UDPHeader.new(udp_src: event.src_port, udp_dst: event.dst_port).to_s
elsif event.proto == 'ICMP'
#   ip =+ PacketFu::ICMPHeader.new().to_s
else
  raise "Unknown proto"
end

header = PacketFu::PcapHeader.new # for IP RAW Header: (network: [101].pack('L'))
packet = PacketFu::PcapPacket.new(incl_len: pkt.size, orig_len: pkt.size, data: pkt)

File.open('test.pcap', 'wb') do |file|
  file.write header
  file.write packet
end

