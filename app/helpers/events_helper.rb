module EventsHelper
  def clean_whois(whois)
    whois.to_s.each_line.reject{|x| x.strip =~ /^([#%*]|$)/}.join.encode('UTF-8', {invalid: :replace, undef: :replace, replace: '.'})
  end

  def events_by_ip(ip)
    raw(%Q[<span class="mr-2">]+
    link_to("#{ip}", events_path(ip: ip), class: 'mr-1') + " " +
    host_report_link(ip) +
    %Q[</span>])
  end

  def new_rule_from_event(event)
    icon = raw(%Q[<i class="fas fa-fw fa-cog"></i>])
    link_to icon, new_event_rule_path(event_id: event.to_param),
      title: I18n.t('lackmus.create_rule_from_event'),
      class: "btn btn-secondary"
  end
end
