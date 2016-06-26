require 'json'
require 'open-uri'

class Threatcrowd
  attr_reader :ip_addr, :data

  def initialize(options = {})
    options.symbolize_keys!
    @ip_addr = options.fetch(:ip, nil).to_s
    @data    = threat_by_ip unless @ip_addr.nil?
  end

  def self.by_ip(ip)
    self.new(ip: ip)
  end

  def threat_by_ip
    Rails.cache.fetch("threadcrowd/ip/#{ip_addr}", expires_in: 3.days) do
      begin 
        JSON.parse(open(ip_uri(@ip_addr)).read)
      rescue JSON::ParserError => e
        {}
      end
    end
  end

  def malware_md5
    if data.nil?
      # raise "please call threat_by_ip or threat_by_domain first"
      []
    else
      data["hashes"] || []
    end
  end

private
  def ip_uri(ip)
    "https://www.threatcrowd.org/searchApi/v2/ip/report/?ip=#{ip}"
  end
end
