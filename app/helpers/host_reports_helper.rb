module HostReportsHelper
  def host_report_link(ip)
    link_to "host_report", show_host_report_path(ip: ip), class: "btn btn-default btn-xs"
  end

end
