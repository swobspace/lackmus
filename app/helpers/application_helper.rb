module ApplicationHelper
  include Wobapphelpers::Helpers::All

  def configuration_active_class
    if Lackmus::CONFIGURATION_CONTROLLER.include?(controller.controller_name.to_s)
      "active"
    end
  end

  def threatcrowd_link(options = {})
    options.symbolize_keys!
    msg = "threatcrowd.org"
    if ip = options.fetch(:ip, nil)
      return "" if IpLookup.is_special?(ip)
      threat = Threatcrowd.by_ip(ip)
      btncolor = if threat.malware_md5.size >= 5
                    'btn-outline-danger'
                  elsif threat.malware_md5.size > 1
                    'btn-outline-warning'
                  elsif threat.malware_md5.size == 1
                    'btn-outline-primary'
                  else
                    'btn-outline-info'
                  end
      link_to msg, "https://www.threatcrowd.org/ip.php?ip=#{ip}",
              target: "_blank", class: "btn #{btncolor} btn-sm"
    elsif domain = options.fetch(:domain, nil)
      link_to msg, "https://www.threatcrowd.org/domain.php?domain=#{domain}",
              target: "_blank", class: "btn btn-outline-info btn-sm"
    end
  end

  def ipintel_link(options = {})
    options.symbolize_keys!
    msg = "ipintel.io"
    if ip = options.fetch(:ip, nil)
      return "" if IpLookup.is_special?(ip)
      link_to msg, "https://ipintel.io/#{ip}",
              target: "_blank", class: "btn btn-outline-info btn-sm"
    end
  end
end
