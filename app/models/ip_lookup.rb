class IpLookup
  attr_reader :ip_addr
  def initialize(ip)
    @ip_addr = ip.to_s
  end

  def self.hostname(ip)
    self.new(ip).get_hostname
  end

  def self.whois(ip)
    self.new(ip).get_whois
  end

  def get_hostname
    Rails.cache.fetch("ip/#{ip_addr}/hostname") do
      begin 
        Resolv.getname(ip_addr)
      rescue Resolv::ResolvError => e
        nil
      end
    end
  end

  def get_whois
    return nil if @ip_addr =~ /(0.0.0.0|255.255.255.255)/
    Rails.cache.fetch("ip/#{ip_addr}/whois") do
      begin
        Whois::Client.new(timeout: 2).lookup(ip_addr)
      rescue Timeout::Error => e
        nil
      end
    end
  end

end
