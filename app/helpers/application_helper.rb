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
      threat = Threatcrowd.by_ip(ip)
      btncolor = if threat.malware_md5.size >= 5
                    'btn-danger'
                  elsif threat.malware_md5.size > 1
                    'btn-warning'
                  elsif threat.malware_md5.size == 1
                    'btn-primary'
                  else
                    'btn-info'
                  end
      link_to msg, "https://www.threatcrowd.org/ip.php?ip=#{ip}",
              target: "_blank", class: "btn #{btncolor} btn-xs"
    elsif domain = options.fetch(:domain, nil)
      link_to msg, "https://www.threatcrowd.org/domain.php?domain=#{domain}",
              target: "_blank", class: "btn btn-info btn-xs"
    end
  end

  def ipintel_link(options = {})
    options.symbolize_keys!
    msg = "ipintel.io"
    if ip = options.fetch(:ip, nil)
      link_to msg, "https://ipintel.io/#{ip}",
              target: "_blank", class: "btn btn-info btn-xs"
    end
  end
end
