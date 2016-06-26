module ApplicationHelper
  include Wobapphelpers::Helpers::All

  def configuration_active_class
    if Lackmus::CONFIGURATION_CONTROLLER.include?(controller.controller_name.to_s)
      "active"
    end
  end

  def threatcrowd_link(options = {})
    options.symbolize_keys!
    threatcrowd = "threatcrowd.org"
    if ip = options.fetch(:ip, nil)
      link_to threatcrowd, 
              "https://www.threatcrowd.org/ip.php?ip=#{ip}",
              target: "_blank", class: "btn btn-info btn-xs"
    elsif domain = options.fetch(:domain, nil)
      link_to threatcrowd, 
              "https://www.threatcrowd.org/domain.php?domain=#{domain}",
              target: "_blank", class: "btn btn-info btn-xs"
    end
  end

end
