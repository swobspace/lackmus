#!/usr/bin/env ruby
# -*- encoding : utf-8 -*-
# parses eve-json entries from suricata in syslog files
# and create a pcap file
#
# This file is part of the lackmus rails application
# https://github.com/swobspace/lackmus
#
# Author::  Wolfgang Barth (wob (at) swobspace dot net)
# Copyright:: Copyright (C) 2016 Wolfgang Barth
# License:: The MIT License, see LICENSE file

require 'json'
require 'base64'
require 'packetfu'
require 'time'

# parse a syslog line
# parse_syslog(line) # => (packet, payload)
# * packet: raw packet in binary format (always Base64 decoded)
# * payload: raw payload in binary format (always Base64 decoded)
def parse_syslog(line)
  return [] unless line =~ /suricata.*"timestamp"/
  m = line.match(/\A([A-Za-z]{3} [ 0-9]{2} \d\d:\d\d:\d\d) (\w+) suricata.*\[\d+\]: (\{.+\})/)
  begin
    hash = JSON.parse(m[3])
  rescue
    return []
  end
  [ Time.parse(hash["timestamp"]), Base64.decode64(hash["packet"]), Base64.decode64(hash["payload"]) ]
end

# process suricata eve logs in syslog files

logfile = ARGV.shift
pcapfile = ARGV.shift

if pcapfile.nil?
  puts "Usage: #{__FILE__} syslog_file pcap_file"
  exit 1
end

header = PacketFu::PcapHeader.new # for IP RAW Header: (network: [101].pack('L'))

File.open(pcapfile, 'wb') do |pcap|
  pcap.write header
  open(logfile, 'r') do |file|
    file.each_line do |line|
      (timestamp, packet, payload) = parse_syslog(line)
      next if packet.nil?
      # to be replace later by logging method
      puts timestamp

      packetfutimestamp = PacketFu::Timestamp.new(
                            sec: timestamp.to_i, 
                            usec: ((timestamp.to_f - timestamp.to_i) * 10**6).to_i
                          )

      pkt = PacketFu::Packet.parse(packet)
      pkt.payload = payload
      pkt.recalc
      packet = PacketFu::PcapPacket.new(incl_len: pkt.size, orig_len: pkt.size, 
                                        data: pkt, timestamp: packetfutimestamp.to_s)
      pcap.write packet
    end
  end
end



