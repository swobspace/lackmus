module EventsHelper
  def clean_whois(whois)
    whois.to_s.each_line.reject{|x| x.strip =~ /^([#%*]|$)/}.join.encode('UTF-8', {invalid: :replace, undef: :replace, replace: '.'})
  end

  def events_by_ip(ip)
    link_to("#{ip}", events_path(ip: ip)) + " " +
    host_report_link(ip)
  end

  def new_rule_from_event(event)
    button  = %Q[<button type="button" class="btn btn-secondary">]
    button += %Q[<span class="glyphicon glyphicon-cog" aria-hidden="true"></span>]
    button += %Q[</button>]

    link_to button.html_safe, new_event_rule_path(event_id: event.to_param),
      title: I18n.t('lackmus.create_rule_from_event')
  end
end
