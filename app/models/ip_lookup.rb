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
    self.new(ip).private_subnet?
  end

  def self.is_multicast?(ip)
    self.new(ip).multicast_subnet?
  end

  def self.is_linklocal?(ip)
    self.new(ip).linklocal_subnet?
  end

  def self.is_broadcast?(ip)
    self.new(ip).broadcast_address?
  end

  def self.is_special?(ip)
    myip = self.new(ip)
    myip.private_subnet? || myip.linklocal_subnet? || 
      myip.multicast_subnet? || myip.broadcast_address?
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
    return "Broadcast address" if @ip_addr =~ /(0.0.0.0|255.255.255.255)/
    if is_ip?
      return "Private address range" if private_subnet?
      return "Multicast address range" if multicast_subnet?
      return "Link local address range" if linklocal_subnet?
    end
    Rails.cache.fetch("ip/#{ip_addr}/whois") do
      begin
        Whois::Client.new(timeout: 2).lookup(ip_addr)
      rescue Timeout::Error => e
        nil
      end
    end
  end

  def is_ip?
    @ip_addr =~ /\A[0-9]{0,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\z/
  end

  def private_subnet?
    @private_class_a ||= IPAddr.new('10.0.0.0/8')
    @private_class_b ||= IPAddr.new('172.16.0.0/12')
    @private_class_c ||= IPAddr.new('192.168.0.0/16')

    @private_class_a.include?(@ip_obj) ||
      @private_class_b.include?(@ip_obj) ||
      @private_class_c.include?(@ip_obj)
  end

  def multicast_subnet?
    @multicast ||= IPAddr.new('224.0.0.0/4')
    @multicast.include?(@ip_obj)
  end

  def linklocal_subnet?
    @linklocal ||= IPAddr.new('169.254.0.0/16')
    @linklocal.include?(@ip_obj)
  end

  def broadcast_address?
    @ip_addr =~ /(0.0.0.0|255.255.255.255)/
  end

end
