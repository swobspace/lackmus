#!/usr/bin/env ruby
# -*- encoding : utf-8 -*-

ENV['RAILS_ENV'] ||= 'development'
require File.dirname(__FILE__) + '/../config/environment.rb'

event_id = ARGV[0]

event = Event.where(id: event_id).first || Event.last

packet  = Base64.decode64(event.packet)
payload = Base64.decode64(event.payload)

pkt = PacketFu::Packet.parse(packet)
pkt.payload = payload
pkt.recalc

header = PacketFu::PcapHeader.new # for IP RAW Header: (network: [101].pack('L'))
packet = PacketFu::PcapPacket.new(incl_len: pkt.size, orig_len: pkt.size, data: pkt)

File.open('test.pcap', 'wb') do |file|
  file.write header
  file.write packet
end

