require 'ipaddr'

class IpLookup
  attr_reader :ip_addr
  def initialize(ip)
    @ip_obj  = ip
    @ip_addr = ip.to_s
  end

  def self.hostname(ip)
    self.new(ip).get_hostname
  end

  def self.whois(ip)
    self.new(ip).get_whois
  end

  def self.is_private?(ip)
    self.new(ip).check_private_subnet
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

  def check_private_subnet
    @private_class_a ||= IPAddr.new('10.0.0.0/8')
    @private_class_b ||= IPAddr.new('172.16.0.0/12')
    @private_class_c ||= IPAddr.new('192.168.0.0/16')

    @private_class_a.include?(@ip_obj) ||
      @private_class_b.include?(@ip_obj) ||
      @private_class_c.include?(@ip_obj)
  end

end
