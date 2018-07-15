module HostReportsHelper
  def host_report_link(ip)
    link_to(
      icon_hsquare, show_host_report_path(ip: ip), 
        class: "btn btn-outline-secondary btn-sm mr-1", 
        title: "host report"
    )
  end

  def icon_hsquare
    raw("<i class='fas fa-h-square'></i>")
  end

end
